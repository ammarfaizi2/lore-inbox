Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312431AbSC3KUU>; Sat, 30 Mar 2002 05:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312442AbSC3KUJ>; Sat, 30 Mar 2002 05:20:09 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:50705 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312431AbSC3KTw>; Sat, 30 Mar 2002 05:19:52 -0500
Date: Sat, 30 Mar 2002 10:19:42 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5: bad config
Message-ID: <20020330101942.A24696@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.21.0203291842530.6417-100000@freak.distro.conectiva> <3CA502A0.54547786@eyal.emu.id.au> <20020330090602.B23576@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2002 at 09:06:02AM +0000, Russell King wrote:
> On Sat, Mar 30, 2002 at 11:11:12AM +1100, Eyal Lebedinsky wrote:
> > In drivers/mtd/maps/Config.in CONFIG_ARM is used in the condition, so
> > maybe a better patch will be to do the same here? I leave this to the
> > experts.
> 
> I have a patch for this.

Those of you using BK can apply the attached BK patch.  Those who aren't
can apply the unified diff.  This is an equal opportunities patch. 8)

===== drivers/pcmcia/Config.in 1.5 vs 1.6 =====
--- 1.5/drivers/pcmcia/Config.in	Tue Mar  5 16:51:18 2002
+++ 1.6/drivers/pcmcia/Config.in	Sat Mar 30 09:53:17 2002
@@ -24,6 +24,8 @@
       dep_tristate '  HD64465 host bridge support' CONFIG_HD64465_PCMCIA $CONFIG_PCMCIA
    fi
 fi
-dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_ARCH_SA1100 $CONFIG_PCMCIA
+if [ "$CONFIG_ARM" = "y" ]; then
+   dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_ARCH_SA1100 $CONFIG_PCMCIA
+fi
 
 endmenu



This BitKeeper patch contains the following changesets:
rmk@flint.arm.linux.org.uk|ChangeSet|20020330095920|10220
## Wrapped with uu ##


begin 664 bkpatch24690
M(R!)1#H)=&]R=F%L9'-`871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T
M?#(P,#(P,C`U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*(R!5<V5R
M.@ER;6L*(R!(;W-T.@EF;&EN="YA<FTN;&EN=7@N;W)G+G5K"B,@4F]O=#H)
M+W5S<B]S<F,O;&EN=7@M8FLM,BXT+VQI;G5X+3(N-"UT;VUA<F-E;&\*"B,@
M4&%T8V@@=F5R<SH),2XS"B,@4&%T8V@@='EP93H)4D5'54Q!4@H*/3T@0VAA
M;F=E4V5T(#T]"G1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG
M95-E='PR,#`R,#(P-3$W,S`U-GPQ-C`T-WQC,60Q,6$T,65D,#(T.#8T"G)M
M:T!F;&EN="YA<FTN;&EN=7@N;W)G+G5K?$-H86YG95-E='PR,#`R,#,R-C(P
M-#`R,WPQ,#(Q.0I$(#$N,CDU(#`R+S`S+S,P(#`Y.C4Y.C(P*S`P.C`P(')M
M:T!F;&EN="YA<FTN;&EN=7@N;W)G+G5K("LQ("TP"D(@=&]R=F%L9'-`871H
M;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C`U,3<S,#4V?#$V
M,#0W?&,Q9#$Q830Q960P,C0X-C0*0PIC(%!R979E;G0@<V5L96-T:6]N(&]F
M($%232!O<'1I;VYS('=I=&@@;F]N+4%232!A<F-H:71E8W1U<F5S"DL@,3`R
M,C`*4"!#:&%N9V53970*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM"@HP83`*/B!T;W)V86QD<T!A=&AL;VXN=')A
M;G-M971A+F-O;7QD<FEV97)S+W!C;6-I82]#;VYF:6<N:6Y\,C`P,C`R,#4Q
M-S0P,3A\-38Y-3-\9C,Y-S$Q8S)D,V4W,60X."!R;6M`9FQI;G0N87)M+FQI
M;G5X+F]R9RYU:WQD<FEV97)S+W!C;6-I82]#;VYF:6<N:6Y\,C`P,C`S,S`P
M.34S,3=\,#@T,38*"CT](&1R:79E<G,O<&-M8VEA+T-O;F9I9RYI;B`]/0IT
M;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7QD<FEV97)S+W!C;6-I82]#
M;VYF:6<N:6Y\,C`P,C`R,#4Q-S0P,3A\-38Y-3-\9C,Y-S$Q8S)D,V4W,60X
M.`IR;6M`9FQI;G0N87)M+FQI;G5X+F]R9RYU:WQD<FEV97)S+W!C;6-I82]#
M;VYF:6<N:6Y\,C`P,C`S,C,Q-S0R,#1\,#4Y,#D*1"`Q+C8@,#(O,#,O,S`@
M,#DZ-3,Z,3<K,#`Z,#`@<FUK0&9L:6YT+F%R;2YL:6YU>"YO<F<N=6L@*S,@
M+3$*0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\
M,C`P,C`R,#4Q-S,P-39\,38P-#=\8S%D,3%A-#%E9#`R-#@V-`I#"F,@5W)A
M<"!!4DT@4$--0TE!(&]P=&EO;G,@:6X@0T].1DE'7T%232!C;VYD:71I;VYA
M;"X*2R`X-#$V"D\@+7)W+7)W+7(M+0I0(&1R:79E<G,O<&-M8VEA+T-O;F9I
M9RYI;@HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2T*"D0R-R`Q"DDR-R`S"FEF(%L@(B1#3TY&24=?05)-(B`](")Y
M(B!=.R!T:&5N"B`@(&1E<%]T<FES=&%T92`G("!303$Q,#`@<W5P<&]R="<@
M0T].1DE'7U!#34-)05]303$Q,#`@)$-/3D9)1U]!4D-(7U-!,3$P,"`D0T].
I1DE'7U!#34-)00IF:0H*(R!0871C:"!C:&5C:W-U;3TP8S%F-V,P-0H`
`
end


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

