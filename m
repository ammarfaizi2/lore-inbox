Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267718AbSLGB5X>; Fri, 6 Dec 2002 20:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267722AbSLGB5X>; Fri, 6 Dec 2002 20:57:23 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:56846 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267718AbSLGB5A>; Fri, 6 Dec 2002 20:57:00 -0500
Date: Sat, 7 Dec 2002 00:04:28 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>, jgarzik@pobox.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCHES] trivial compile fix patches
Message-ID: <20021207020428.GA8891@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>, jgarzik@pobox.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

	Please consider pulling from:

bk://kernel.bkbits.net/acme/misc-2.5

	There are 10 outstanding patches, all attached.

	Jeff, there are some for drivers/net, please take a look.

- Arnaldo

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.106.1.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.106.1, 2002-11-23 14:11:41-02:00, acme@conectiva.com.br
  o ambassador: set_bit & friends require a long
  
  Also make drain_rx_pools always available, it is called outside
  #ifdef CONFIG_MODULE.


 ambassador.c |    4 ----
 ambassador.h |    2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)


diff -Nru a/drivers/atm/ambassador.c b/drivers/atm/ambassador.c
--- a/drivers/atm/ambassador.c	Fri Dec  6 23:18:33 2002
+++ b/drivers/atm/ambassador.c	Fri Dec  6 23:18:33 2002
@@ -795,7 +795,6 @@
   return;
 }
 
-#ifdef MODULE
 static void drain_rx_pools (amb_dev * dev) {
   unsigned char pool;
   
@@ -803,10 +802,7 @@
   
   for (pool = 0; pool < NUM_RX_POOLS; ++pool)
     drain_rx_pool (dev, pool);
-  
-  return;
 }
-#endif
 
 static inline void fill_rx_pool (amb_dev * dev, unsigned char pool, int priority) {
   rx_in rx;
diff -Nru a/drivers/atm/ambassador.h b/drivers/atm/ambassador.h
--- a/drivers/atm/ambassador.h	Fri Dec  6 23:18:33 2002
+++ b/drivers/atm/ambassador.h	Fri Dec  6 23:18:33 2002
@@ -627,7 +627,7 @@
 
 struct amb_dev {
   u8               irq;
-  u8               flags;
+  long		   flags;
   u32              iobase;
   u32 *            membase;
 

===================================================================


This BitKeeper patch contains the following changesets:
1.797.106.1
## Wrapped with gzip_uu ##


begin 664 bkpatch18729
M'XL(`&E,\3T``^6674_;,!2&K^M?<22DW6Q)?)Q/9^I4H(PAV$!,7%>NXS81
M2<QBMX"4'S]3)+JQ0:';'8FE(^7$Q^?C>:/LP(5173X0LE%D![YH8_.!U*V2
MMEH*7^K&GW;.<:ZU<P2E;E2P=QPTE9$>\V/B7&?"RA*6JC/Y`/WPX8F]O5+Y
MX/S@\.)D]YR0X1#V2]'.U7=E83@D5G=+41=F)&Q9Z]:WG6A-H^SJT/[AU9Y1
MRMP=8QK2..DQH5':2RP0182JH"S*DF@=[4JU\T7U?#A$QAB&'),^9L@3,@;T
M4Y[Z2!,?@;(`,6`A8)0CYA%ZE.64PEV/1H][`^\9>)3LP?^M9Y](T"":J3!&
M%+K+P2@[F586WL&LJU1;&.C4CT75*1#@SIN[#6[MUD9#(RX5%)VHVDEW,[G2
MNC8@ZFMQZ\Q25+68UNH#N%B5`2GJ6A6@%]94A7(1=JI9H6:P?_KM\]'AY.OI
M^.+DP"?'$$>4(CE;#Y%XK[P(H8*23QLZ5735'4N!L$VPKM^7OS0NHICU&")-
M>S7-5#&5BJ5<II*+OP_I^:`.AQ`3=.7US$V#;YMB^6>*:<9ZD<4X2V,N)<,T
MI<7K4BP?ITB3+,*5G)XJ:K.Z_JW'I)3EJ#;6+]2&QE+*7:0PXCW+XI"M=,9_
MUQ?-Z09]4?"B-Z"O>_1.P>NN5\OIY>S)$6^AO7'*,T`RSF@"[,YP>!:C<FN,
M7J@#TE3M7(]4;95?+C;P[\A'QQ)+'/\\RE8D1:\E"<'#-T#2Z@/Q,I#*;4!*
J0NK0.;HWL"II,`"`62WFYN/ZET"62EZ:13,4,QZG/!+D)YN8F"1N"```
`
end

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.106.2.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.106.2, 2002-11-23 14:30:46-02:00, acme@conectiva.com.br
  o drivers/atm/horizon.c: test_bit & friends require long 


 horizon.c |    7 +++----
 horizon.h |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)


diff -Nru a/drivers/atm/horizon.c b/drivers/atm/horizon.c
--- a/drivers/atm/horizon.c	Fri Dec  6 23:18:26 2002
+++ b/drivers/atm/horizon.c	Fri Dec  6 23:18:26 2002
@@ -603,8 +603,7 @@
   
   // note: rounding the rate down means rounding 'p' up
   
-  const unsigned long br = test_bit (ultra, (hrz_flags *) &dev->flags) ?
-    BR_ULT : BR_HRZ;
+  const unsigned long br = test_bit(ultra, &dev->flags) ? BR_ULT : BR_HRZ;
   
   u32 div = CR_MIND;
   u32 pre;
@@ -1106,9 +1105,9 @@
 
 static inline int tx_hold (hrz_dev * dev) {
   while (test_and_set_bit (tx_busy, &dev->flags)) {
-    PRINTD (DBG_TX, "sleeping at tx lock %p %u", dev, dev->flags);
+    PRINTD (DBG_TX, "sleeping at tx lock %p %lu", dev, dev->flags);
     interruptible_sleep_on (&dev->tx_queue);
-    PRINTD (DBG_TX, "woken at tx lock %p %u", dev, dev->flags);
+    PRINTD (DBG_TX, "woken at tx lock %p %lu", dev, dev->flags);
     if (signal_pending (current))
       return -1;
   }
diff -Nru a/drivers/atm/horizon.h b/drivers/atm/horizon.h
--- a/drivers/atm/horizon.h	Fri Dec  6 23:18:26 2002
+++ b/drivers/atm/horizon.h	Fri Dec  6 23:18:26 2002
@@ -429,7 +429,7 @@
 #endif
 
   u8                  irq;
-  u8                  flags;
+  long		      flags;
   u8                  tx_last;
   u8                  tx_idle;
 

===================================================================


This BitKeeper patch contains the following changesets:
1.797.106.2
## Wrapped with gzip_uu ##


begin 664 bkpatch18697
M'XL(`&),\3T``\V574_;,!B%K^M?\0H$8AI)_3J)\X'*6.D$"+15'4C3;E#J
MF"8B'RQVRS;EQ\]--YB@XZ/L`B>*HS@Z[_')XW@=SI2LHTXL"DG6X;!2.NJ(
MJI1"9[/8%E5ACVLS,*HJ,]!-JT)V^\?=(E/"8K9'S-`PUB*%F:Q5U$';N7FB
M?US)J#/Z<'!V\GY$2*\'^VE<3N1GJ:'7([JJ9W&>J+U8IWE5VKJ.2U5(W19M
M;EYM&*7,'![Z#O5X@YRZ?B,P08Q=E`EE;L!=,O>_=]?W'15$YB!'=+'Q7$J1
M#`!M/_1MI-QF0%D7L<L<0#=R:.1RB[*(4E@J#6\96)3TX?].8Y\(J""ILWF<
MW5@7)O$Z^VET101:*GT^SC1LPD6=R3)14,MOTZR68"I/@!R#YZ*'9'B;-+&>
MV0BA,26[C\QKJ<._YNA2#!KT0QHVX_@B\,-D[#H2*?IB>9X/*"X^FT-=IV$\
M=(*5S*7WS`6<T49X8<C](!F''B*&S_"6WO7&3?+88KYT*H\C_X),22K2O5QI
M.Y$/!4EI:&0\`QX+*/5;_H-[W#L/<^^`Y;XZ[A=@?`*KOFY/P_%PN=P*"V+`
M*0=&CCCU`0F`R41IF)8JFY0R67@PR?1NC&Y-<Q/'-FPF<F;M7N3Q1+V!=]`?
MG9^=G$(TOSD<?=TA`T0:&LFCWSV8-AP=?3P=P-:@?W!^^F4;UE0NY55F2L0:
M]'=335S"QA5LY-.U;3`%VLN?*JTFXD*S[9=J7E>7LGRBX+^(3E<C^FD+\>7"
MH5F0'(.6\?O_]D<81[#PU3&^^,$\@?%T%<9=A\VI6730%NUTH&TM"3NW6[U(
5I;A4TZ*'9AOUY%B27R00?:M&"```
`
end

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.106.3.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.106.3, 2002-11-23 14:38:52-02:00, acme@conectiva.com.br
  o drivers/char/sx.c: test_bit and friends require a long


 sx.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/sx.h b/drivers/char/sx.h
--- a/drivers/char/sx.h	Fri Dec  6 23:18:19 2002
+++ b/drivers/char/sx.h	Fri Dec  6 23:18:19 2002
@@ -44,7 +44,7 @@
   int poll;
   int ta_type;
   struct timer_list       timer;
-  int                     locks;
+  long                    locks;
 };
 
 struct vpd_prom {

===================================================================


This BitKeeper patch contains the following changesets:
1.797.106.3
## Wrapped with gzip_uu ##


begin 664 bkpatch18663
M'XL(`%M,\3T``\V4WV_3,!#'G^N_XJ0]HB9WCIU?4U#9A@`-B:IHS\AU3!/1
MQ&"[!:3\\60!;:CK5#'Q,-OR@\^Z^][7'_D,;KQQY4SISK`S>&M]*&?:]D:'
M=J\B;;MH[<;`RMHQ$#>V,_'%==RU7L]Y)-D86JJ@&]@;Y\L91<G=2?CYU92S
MU>LW-^]?K1BK*KAL5+\Q'TV`JF+!NKW:UGZA0K.U?12<ZGUGPE1TN+LZ<$0^
M3DE9@C(=*$61#9IJ(B7(U,A%G@IVJW]QJ/L@"Q%/*$U0I(,4)(E=`459D46$
M:90`\I@HY@F0*).\E'R.O$2$HZGA!<$<V07\WS8NF08+M6MO[8QUHUSL?T2Z
MA&!\^+1N`ZB^AL^N-7WMP9EON]894#!6WK!KD*(@8LM[H]G\'P=CJ)"]/-'6
MH<#FK_8$HAPDYX*&1!2H$I,*9=9HN#INY2/9_KQ6+HJ!LD*(B:`'5T^3]$2M
MK&O[C5V8;3!1LWM,(R)101G/1HUY)B>BQ"%)HCA)$CTWDGY;_@'F[ONT1C*6
M#]U_`EY7(@-B[Z8=IFIP9&RM_N+/[W\7W9CQ8-=5><X3D2-GOP#3X*[UN00`
!````
`
end

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.106.4.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.106.4, 2002-11-23 15:01:54-02:00, acme@conectiva.com.br
  o hdlcdrv.c: set_bit and friends require a long


 hdlcdrv.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/hdlcdrv.h b/include/linux/hdlcdrv.h
--- a/include/linux/hdlcdrv.h	Fri Dec  6 23:18:12 2002
+++ b/include/linux/hdlcdrv.h	Fri Dec  6 23:18:12 2002
@@ -214,7 +214,7 @@
 
 	struct hdlcdrv_hdlctx {
 		struct hdlcdrv_hdlcbuffer hbuf;
-		int in_hdlc_tx;
+		long in_hdlc_tx;
 		/*
 		 * 0 = send flags
 		 * 1 = send txtail (flags)

===================================================================


This BitKeeper patch contains the following changesets:
1.797.106.4
## Wrapped with gzip_uu ##


begin 664 bkpatch18631
M'XL(`%1,\3T``\V4;6O5,!3'7S>?XL!>2MN</#1KI3*WB<H$+U?V^I(F<2WV
M0=/<ZX1^>'L[W&1N7M2],`D$<I+_>?J1([@<G2\B;3I'CN#-,(8B,D/O3&AV
M.C%#EU1^-JR'83:D]="Y]/0B[9K1Q"R19#:M=#`U[)P?BP@3?GL2OGUV1;1^
M]?KRW<LU(64)9[7NK]P'%Z`L21C\3K=V/-&A;H<^"5[W8^?"XG2ZO3HQ2MD\
M)2I.939A1H6:#%I$+=!9RL1Q)L@^_I/[<=]3060<,WXLV21%CDC.`1.5JP1I
ME@B@+$5,&0>4!<5"BIBR@E)X4!J>(<24G,+3IG%&#`Q0V]98OTM,`:,+FZH)
MH'L+'WWC>CN"=U^VC7>@879X12Y`\CQ39'577Q+_X2"$:DI>',BFZ4V[M2YM
MFWY[G?Z(LOXYMUS@Q)6@?$*952;G>26T,<H^7,;?2B[]4A0E3D)2+A>&'GEP
MF*A_"?XII-DD1,[%`AW[!38\"!O^)[#=M.(]Q/[KLF9X5H]UY2\X/&>H`,G;
FFRV*]EYG^<U><Q.NG]_].*9VYM.X[4JM:26EE>0[.L<-],T$````
`
end

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.106.5.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.106.5, 2002-11-23 15:19:15-02:00, acme@conectiva.com.br
  o fealnx: fix up some printk paramenters


 fealnx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/net/fealnx.c b/drivers/net/fealnx.c
--- a/drivers/net/fealnx.c	Fri Dec  6 23:18:05 2002
+++ b/drivers/net/fealnx.c	Fri Dec  6 23:18:05 2002
@@ -1155,8 +1155,8 @@
 	unsigned int old_linkok = np->linkok;
 
 	if (debug)
-		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8lx "
-		       "config %8.8lx.\n", dev->name, readl(ioaddr + ISR),
+		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8x "
+		       "config %8.8x.\n", dev->name, readl(ioaddr + ISR),
 		       readl(ioaddr + TCRRCR));
 
 	if (np->flags == HAS_MII_XCVR) {
@@ -1184,7 +1184,7 @@
 	long ioaddr = dev->base_addr;
 	int i;
 
-	printk(KERN_WARNING "%s: Transmit timed out, status %8.8lx,"
+	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
 	       " resetting...\n", dev->name, readl(ioaddr + ISR));
 
 	{
@@ -1555,7 +1555,7 @@
 	np->stats.rx_crc_errors += (readl(ioaddr + TALLY) & 0x7fff0000) >> 16;
 
 	if (debug)
-		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4lx.\n",
+		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 		       dev->name, readl(ioaddr + ISR));
 
 	writel(np->imrvalue, ioaddr + IMR);

===================================================================


This BitKeeper patch contains the following changesets:
1.797.106.5
## Wrapped with gzip_uu ##


begin 664 bkpatch18599
M'XL(`$U,\3T``\64;6O;,!2%/T>_XI)2Z%ALZ\J6WR"EKW2E6Q?2E7T9#%56
M&M'8#K:29>`?/]D>*>W2PL;&9.,+ECA^[KD'[\%MK:IT(&2NR!Z\*VN3#F19
M*&GT6KBRS-V[RFY,R])N>/,R5][)E9?K6CK,Y<1N3821<UBKJDX'Z/K;-^;[
M4J6#Z?G%[?OC*2'C,9S.17&O;I2!\9B8LEJ+158?"3-?E(5K*E'4N3+=1YOM
MT891RNS%,?(I#QL,:1`U$C-$$:#**`OB,"`M_]%S[F<JB,S'B"(/&NXG843.
M`-THB5RDH<N!,@_18SX@3S%)D3N4I93"3FEXB^!0<@)_MXU3(J&$F1*+8I/"
M3&]@M83:F@[+2A?F`9:B$KDJC'6;7(%M(XK)Y-%8XOSF(H0*2@ZMKAW9[AZR
M2K?#]0IEO)[,E8_MQ!ABW""E"6_\!),9RBR)DAE/@F"W=2\+]@/"!%GC(_IQ
M%YI=I]O\_!/B%W+T&C$R1D-$2\PCVD6*L5^RQ%[/4@!.\+^SU#O^$9SJ6W?;
M;$QVFO\'&3M#Y#$P<FEK8NM@T",<7)U/K[^>G9_<7L!POT[A@\JT@%HM6H/*
M`HS.566?\F$$M1%F5<-^[,8;&%H-Z-?0^CG3]_V&^Z48CB!3:^>PL,V-H%(B
M6QSH4F29-1HN;Z9O1BU/'`&V/%U]@O/Y>'I]>?T3Z%,W`FTZD@S*E7D*,AI:
M,6Z;:\7Z^F)S:J.-+NY!MY97J^56:KR_%[A!S_[X1Y5S)1_J53[V^5V<4#\C
*/P`1F:;YK04`````
`
end

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.106.6.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.106.6, 2002-11-23 15:26:52-02:00, acme@conectiva.com.br
  o drivers/net/setup.c: fix special_device_init struct initialization
  
  struct net_device changed, making sb1000_probe not match with the
  .init position, convert it to C99 initializers so that doesn't happens
  anymore when net_device changes again.


 setup.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)


diff -Nru a/drivers/net/setup.c b/drivers/net/setup.c
--- a/drivers/net/setup.c	Fri Dec  6 23:17:58 2002
+++ b/drivers/net/setup.c	Fri Dec  6 23:17:58 2002
@@ -142,14 +142,13 @@
 static void __init special_device_init(void)
 {
 #ifdef CONFIG_NET_SB1000
-	{
-		extern int sb1000_probe(struct net_device *dev);
-		static struct net_device sb1000_dev = 
-		{
-			"cm0" __PAD3, 0x0, 0x0, 0x0, 0x0, 0, 0, 0, 0, 0, NULL, sb1000_probe 
-		};
-		register_netdev(&sb1000_dev);
-	}
+	extern int sb1000_probe(struct net_device *dev);
+
+	static struct net_device sb1000_dev = {
+		.name = "cm0" __PAD3,
+		.init = sb1000_probe,
+	};
+	register_netdev(&sb1000_dev);
 #endif
 }
 

===================================================================


This BitKeeper patch contains the following changesets:
1.797.106.6
## Wrapped with gzip_uu ##


begin 664 bkpatch18567
M'XL(`$9,\3T``^U576_3,!1]CG_%U2;!@#6UG>],16,;`C0DJJ&](56N8QK3
MQ:YBK]L@_'=NNFEC6V%B@C<22W%\XW./S[U'V81CI]HR$+)19!/>6N?+0%JC
MI-=+$4K;A-,6`T?68F!8VT8-]PZ'C79RP,.$8&@LO*QAJ5I7!BR,KE?\Q4*5
MP='K-\?O7QT1,AK!?BW,3'U4'D8CXFV[%">5VQ6^/K$F]*TPKE%^E;2[_K3C
ME'*\$Y9%-$D[EM(XZR2K&!,Q4Q7E<9[&I.>_>Y?W'13&>,0R5K"D2Z(BR\D!
ML#`KLI#1-$R!\B%C0QX!2TJ>E@D?4%Y2"FNAX06#`25[\'>/L4\D6*A:W<LY
M-,H/G?*GBU"6\%F?@ULHJ<7)I%)++=5$&^W!^?94>NCG&-)?A=?6(`R.JQ#"
M7.T`N>)3;4,CYMK,P$T9I72R:.U4@;$>U_O2G6F/]:L58H2K)`OK=(^[#2@$
M<L-\'H\.^T5QDQDI@[.X3WBHK'+FJ8=:+!;*.`02YJ*QK8*S6IG[E!R(F=`F
M)(>0Q'$2D?%-MY#!'UZ$4$')RP=JLT;EGZH44\JP2DF6=SF=\B)C+,^5D'):
MK.^(7^)=MAU/XZ+K:YROK+#FXX=-\6C&Y$NEYVIW+EIQ\0!43F/*.(_3+BZ*
M+%IY)+GKC;CXO3<R&.3_O?$/O''90!]@T)ZM!O;Z>)TDC[#,`8L3R,D[EG#(
M2*#.O6H-'L#?$F+KOF[/\?ELAWPB@?,H\#IIKQ#P#4;PC01!:$2C<+XA&[H!
MD\GXU4&TW:^O%!W=2HGKWW=(T*J9=LAI@K@(M/7D!A2S7_]U9*WDW)TVHT(4
.!:TJ17X`/;#E?^,&````
`
end

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.106.7.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.106.7, 2002-11-23 15:42:49-02:00, acme@conectiva.com.br
  o lance.c: set_bit and friends require a long


 lance.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/net/lance.c b/drivers/net/lance.c
--- a/drivers/net/lance.c	Fri Dec  6 23:17:51 2002
+++ b/drivers/net/lance.c	Fri Dec  6 23:17:51 2002
@@ -390,7 +390,7 @@
 static int __init lance_probe1(struct net_device *dev, int ioaddr, int irq, int options)
 {
 	struct lance_private *lp;
-	short dma_channels;					/* Mark spuriously-busy DMA channels */
+	long dma_channels;			/* Mark spuriously-busy DMA channels */
 	int i, reset_val, lance_version;
 	const char *chipname;
 	/* Flags for specific chips or boards. */

===================================================================


This BitKeeper patch contains the following changesets:
1.797.106.7
## Wrapped with gzip_uu ##


begin 664 bkpatch18535
M'XL(`#],\3T``\V4;VO;,!#&7UN?XJ#O.FSK9$F./3SZ)V,;76G(Z.LBRUIM
M&MN=I&0$_.'G)&L[NG1A92]F&0R^X^YY[G[H"*Z=L7F@=&O($7SLG<\#W7=&
M^V:E(MVW46G'P+SOQT!<]ZV)SR[BMG$Z9)$@8VBFO*YA9:S+`XR2QS]^?6_R
M8/[^P_7GTSDA10'GM>INS1?CH2B([^U*+2IWHGR]Z+O(6]6YUOAMT^$Q=6"4
MLO$(3!,JY("2\G306"$JCJ:BC$\D)QO])\]U/ZN"R!),F11L$)R+A$P!HS1+
M(Z0R2H&R&#%F":#(.<MY%E*64PI[2\,;A)"2,_BW-LZ)AAX6JM,FTCDXXV_*
MQH/J*OAJ&]-5#JSYMFRL`05CNUMR`:,7*<CL:;HD_,N'$*HH>7?`2V6;S9+C
MSOCXI\)?7'%*Z8!"RF2HJA(US42*4F>H)_LG^&*]W9HXXW(08L+2+3I[D@]#
M]&K%+^#T!\7(&)6(H^(LW8&%\C>BY$&B\/\@:COV*PCM]^T[$C+;MX%7@#9-
MLG$<Y-/N$VP:0M6J&SW:ZLS"O0V"(#Z&2V7OP-TO;=,OW6(=EDNWANGE*3SD
;P7'\=/?HVN@[MVP+)FDIN$K)#XM#-5_7!```
`
end

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.106.8.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.106.8, 2002-11-23 15:55:41-02:00, acme@conectiva.com.br
  o drivers/net/ni65.c: test_bit and friends require long
  
  Also convert some structs to C99 initialization style.


 ni65.c |   41 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 36 insertions(+), 5 deletions(-)


diff -Nru a/drivers/net/ni65.c b/drivers/net/ni65.c
--- a/drivers/net/ni65.c	Fri Dec  6 23:17:44 2002
+++ b/drivers/net/ni65.c	Fri Dec  6 23:17:44 2002
@@ -184,11 +184,41 @@
 	short addr_offset;
 	unsigned char *vendor_id;
 	char *cardname;
-	unsigned char config;
+	long config;
 } cards[] = {
-	{ NI65_ID0,NI65_ID1,0x0e,0x10,0x0,0x8,ni_vendor,"ni6510", 0x1 } ,
-	{ NI65_EB_ID0,NI65_EB_ID1,0x0e,0x18,0x10,0x0,ni_vendor,"ni6510 EtherBlaster", 0x2 } ,
-	{ NE2100_ID0,NE2100_ID1,0x0e,0x18,0x10,0x0,NULL,"generic NE2100", 0x0 }
+	{
+		.id0	     = NI65_ID0,
+		.id1	     = NI65_ID1,
+		.id_offset   = 0x0e,
+		.total_size  = 0x10,
+		.cmd_offset  = 0x0,
+		.addr_offset = 0x8,
+		.vendor_id   = ni_vendor,
+		.cardname    = "ni6510",
+		.config	     = 0x1,
+       	},
+	{
+		.id0	     = NI65_EB_ID0,
+		.id1	     = NI65_EB_ID1,
+		.id_offset   = 0x0e,
+		.total_size  = 0x18,
+		.cmd_offset  = 0x10,
+		.addr_offset = 0x0,
+		.vendor_id   = ni_vendor,
+		.cardname    = "ni6510 EtherBlaster",
+		.config	     = 0x2,
+       	},
+	{
+		.id0	     = NE2100_ID0,
+		.id1	     = NE2100_ID1,
+		.id_offset   = 0x0e,
+		.total_size  = 0x18,
+		.cmd_offset  = 0x10,
+		.addr_offset = 0x0,
+		.vendor_id   = NULL,
+		.cardname    = "generic NE2100",
+		.config	     = 0x0,
+	},
 };
 #define NUM_CARDS 3
 
@@ -415,7 +445,8 @@
 	else {
 		if(dev->dma == 0) {
 		/* 'stuck test' from lance.c */
-			int dma_channels = ((inb(DMA1_STAT_REG) >> 4) & 0x0f) | (inb(DMA2_STAT_REG) & 0xf0);
+			long dma_channels = ((inb(DMA1_STAT_REG) >> 4) & 0x0f) |
+					    (inb(DMA2_STAT_REG) & 0xf0);
 			for(i=1;i<5;i++) {
 				int dma = dmatab[i];
 				if(test_bit(dma,&dma_channels) || request_dma(dma,"ni6510"))

===================================================================


This BitKeeper patch contains the following changesets:
1.797.106.8
## Wrapped with gzip_uu ##


begin 664 bkpatch18503
M'XL(`#A,\3T``]U6VT[;0!!]]G[%"*0*5.+L^&ZC(`)!+8)2Q.79VMB;9-7$
M;G<76JC[[UW;W!2<(E#5AZXM6SHS.WO.S)&3=;A47"86RQ:<K,/'4NG$RLJ"
M9UI<,SLK%_98FL!969I`?U8N>'_OJ+\0*NLYMD],Z)3I;`;77*K$0MM]0/3-
M5YY89P<?+H^'9X0,!K`_8\64GW,-@P'1I;QF\USM,CV;EX6M)2O4@NOFT.HA
MM7(H=<SE8^A2/Z@PH%Y899@C,@]Y3ATO"CQ2\]]=YKU4!=%Q,?0<+ZY\SPM\
M,@*TPSBTD09V!-3I(_8=%]!/?#_QL$>=A%+H+`WO$7J4[,'?E;%/,B@AEZ)N
M9[_@NE^(P+>S!#17.AT+#:S(82(%+W(%DG^[$I*#.7AJ=II[.%<E&+)FOP9E
MI@5*RZM,*T,4]N,81"&T8'-QR[0H"Q.]F7.;'('I2!B2T\<9D=XK%R&44;+S
M0D>>:WO2&H]2K-#QT3//R.>QF56>Y30.>?<85I5K1^W[;E11ZL5A8[_GN2_[
M\*UT5QAR-5UT'!H@5F[HQJTST5VVI!O]V9)N`#W_/_)D/;C/T)/?F]LX[+2#
MQAM\.L(H!"2'[<NJF=;\)F*Z7<=B<$TL1G!=8OTDEF6+G%I0KP&<'`9^>CBB
M6RV.2SC>X6DYF2CSH:M#]`?E#:Q+S>:I$K>\A;&MDBT>TYOL!F5Y+N_A&HT:
M]-KTN)2IR)O*A4A;H*W#9%XPT]XFME:W!^E:&VK4W7,U)V\1:)?U:VN%R(.]
ME3J;T.ND1IU2L5LK?9M6.-`S+O?F3&DNNX4[+P@_<)#23MWWD7\L^^3R^+A+
M\9077(KLCE>WV+J>43GR,*KM7K\<D]<:/E^P-#.?@H+/E<G>V!#%>&/T:8CI
M^<7P(C6_VYNPLP/>)KRK2TTVH:KW6DWY^V3G27*=-J&;VX__";(9S[ZHJ\4@
01I>[$W],?@-*->K3;P@`````
`
end

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.106.9.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.106.9, 2002-11-24 21:08:35-02:00, acme@conectiva.com.br
  o mxser: add module_exit/module_init
  
  This fixes the compilation problem in 2.5


 mxser.c |   29 +++++------------------------
 1 files changed, 5 insertions(+), 24 deletions(-)


diff -Nru a/drivers/char/mxser.c b/drivers/char/mxser.c
--- a/drivers/char/mxser.c	Fri Dec  6 23:17:37 2002
+++ b/drivers/char/mxser.c	Fri Dec  6 23:17:37 2002
@@ -328,13 +328,7 @@
  * static functions:
  */
 
-#ifdef MODULE
-int init_module(void);
-void cleanup_module(void);
-#endif
-
 static void mxser_getcfg(int board, struct mxser_hwconf *hwconf);
-int mxser_init(void);
 static int mxser_get_ISA_conf(int, struct mxser_hwconf *);
 static int mxser_get_PCI_conf(struct pci_dev *, int, struct mxser_hwconf *);
 static void mxser_do_softint(void *);
@@ -373,21 +367,7 @@
  * The MOXA C168/C104 serial driver boot-time initialization code!
  */
 
-
-#ifdef MODULE
-int init_module(void)
-{
-	int ret;
-
-	if (verbose)
-		printk("Loading module mxser ...\n");
-	ret = mxser_init();
-	if (verbose)
-		printk("Done.\n");
-	return (ret);
-}
-
-void cleanup_module(void)
+static void __exit mxser_module_exit(void)
 {
 	int i, err = 0;
 
@@ -411,8 +391,6 @@
 		printk("Done.\n");
 
 }
-#endif
-
 
 int mxser_initbrd(int board, struct mxser_hwconf *hwconf)
 {
@@ -510,7 +488,7 @@
 	return (0);
 }
 
-int mxser_init(void)
+static int __init mxser_module_init(void)
 {
 	int i, m, retval, b;
 	int n, index;
@@ -2493,3 +2471,6 @@
 	}
 	outb(0x00, port + 4);
 }
+
+module_init(mxser_module_init);
+module_exit(mxser_module_exit);

===================================================================


This BitKeeper patch contains the following changesets:
1.797.106.9
## Wrapped with gzip_uu ##


begin 664 bkpatch18471
M'XL(`#%,\3T``]546VO;,!1^CG[%@;ZLC-@ZNO@V,K(V8RL=K'3KVZ"HLE*+
MQE:PU:P#__C):<FR)FM9V<MLP9%UKI^^#Q_`16?:8J1T;<@!?'2=+T;:-49[
MNU*1=G5TU0;'N7/!$5>N-O'1:5S;3H]9)$EPG2FO*UB9MBM&&/'-B?^Q-,7H
M_/V'BT_OS@F93."X4LVU^6(\3";$NW:E%F4W5;Y:N";RK6JZVOAUTWX3VC-*
M67@EIIS*I,>$BK376"(J@::D3&2)(,/\T\=S/ZJ"R#BF4@KLI1!I2F:`49JG
M$=(DRH&R&#%F`A@6-"NX'%-64`I[2\-KA#$E1_!O81P3#0[JNX$34&4)M2MO
M%^;2W%D?/^QM8WT("^MK93N8VSO3@:\,A(9+NU#>N@:6K;M:F!IL`P--IR`E
MBIR<_>*`C/_R(80J2MX^@[AL[2"%6%>JC==`(KT%7E`J>YF%79\(S3.&<SY/
MJ&)J_SW_N5Y@4S!.,\YZ(45.UPK;%_V\V%X\,U$WRWI:VFOCGBZ$E&:!^5`C
M%.)(U]+#=$=S[&G-21@S\1^)[IZ8SS!NOZ]7$-'97HY>(,89YPAR,"E@,&D"
M*,D)SVGX['R82,/*V1(NUT#N\5UN07LU>`_)3&"X?C*3R$/BR;UYR+>-#^D#
M]M_3AY.']!,F<@F<?"/;OIWHPS=DN_7.,,&_^7'JRNB;[K:>S(TR^95)R$\.
'/TTQI@4`````
`
end

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.909.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.909, 2002-12-06 23:05:11-02:00, acme@conectiva.com.br
  Merge conectiva.com.br:/home/BK/misc-2.5.old
  into conectiva.com.br:/home/BK/misc-2.5


 char/sx.h    |    2 +-
 net/fealnx.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/drivers/char/sx.h b/drivers/char/sx.h
--- a/drivers/char/sx.h	Fri Dec  6 23:17:30 2002
+++ b/drivers/char/sx.h	Fri Dec  6 23:17:30 2002
@@ -44,7 +44,7 @@
   int poll;
   int ta_type;
   struct timer_list       timer;
-  int                     locks;
+  long                    locks;
 };
 
 struct vpd_prom {
diff -Nru a/drivers/net/fealnx.c b/drivers/net/fealnx.c
--- a/drivers/net/fealnx.c	Fri Dec  6 23:17:30 2002
+++ b/drivers/net/fealnx.c	Fri Dec  6 23:17:30 2002
@@ -1155,8 +1155,8 @@
 	unsigned int old_linkok = np->linkok;
 
 	if (debug)
-		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8lx "
-		       "config %8.8lx.\n", dev->name, readl(ioaddr + ISR),
+		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8x "
+		       "config %8.8x.\n", dev->name, readl(ioaddr + ISR),
 		       readl(ioaddr + TCRRCR));
 
 	if (np->flags == HAS_MII_XCVR) {
@@ -1184,7 +1184,7 @@
 	long ioaddr = dev->base_addr;
 	int i;
 
-	printk(KERN_WARNING "%s: Transmit timed out, status %8.8lx,"
+	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
 	       " resetting...\n", dev->name, readl(ioaddr + ISR));
 
 	{
@@ -1554,7 +1554,7 @@
 	np->stats.rx_crc_errors += (readl(ioaddr + TALLY) & 0x7fff0000) >> 16;
 
 	if (debug)
-		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4lx.\n",
+		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 		       dev->name, readl(ioaddr + ISR));
 
 	writel(np->imrvalue, ioaddr + IMR);

===================================================================


This BitKeeper patch contains the following changesets:
1.909
## Wrapped with gzip_uu ##


begin 664 bkpatch18439
M'XL(`"I,\3T``\U634_;0!`]Q[]B)8Y5[)G]\'HMI>*C52O1J(B*4]7#8F_B
MD-A&MJ%0^<=W')6`0DCJ%*0Z/F7WS;Z9?>\E!^RB=E4\L$GNO`/VN:R;>)"4
MA4N:V:WUDS+W+RM:."]+6@BR,G?!\6F0S^IDR'WET=*9;9*,W;JJC@?HB]4W
MS?VUBP?G'S]=?#DZ][S1B)UDMIBZ;ZYAHY'7E-6M7:3UH6VR15GX366+.G?-
M\M!VM;7E`)P^"K4`%;88@M1M@BFBE>A2X#(*Y6.UCN'66L@A1,,U5RT/0VF\
M#PQ]`X8!#Y`'$#(N8E`QXA!X#,"ZT1RNCX2]XVP(WC%[W39.O(2-735U;/W`
M^-GL_7*1TO99T91_L=N;;6YD?3K(!8:($ELE`;`73(`,"8:J)RQ2G&`&>\$T
MH)*M$B;4O6!H4'4P'?6"\7!)4BK1"R:Y-!TL['4!6JGE!4C=HS?)!42">E-(
MJCYE7&M2U'@_^-FC6;UAS\?SP(+W?H<UTFK694:09+8*ZCL_>V(14AX1X9R&
M(*0!*UPHK;L$Q^T+[6RN1EXGF8`"W=(]:$.DKKMLVLZH<$TP<791W/G)(ZF(
M;!&U"&!4*PR:"28IE9PH(^4.4L\*/N6E#6FC2\=-N[N@?!/&7E_&#][AK4`4
MT3(UN5@/3=#;0Q/>*C2/;B@%\RXY4W+,U=16OV;SP\JEF6VVCXJZZ9)$HFAY
M1+&P=$YW)^-_*_.5#:N?RY<<<;;Q=O=PUE.AK+2^^^=T3[/M4,F:V?Z$.04>
MZDYBG434?ZJ0U-ZZ*SH^=7E9S-V]7U93_V;^_>'<'R\W&5)1I*"D1$'HU+),
EEO'KE7Q!.2O4/K)Y^%.69"Z9US?YB+(@FG!(O=]VW06S`@H`````
`
end

--gBBFr7Ir9EOA20Yy--
