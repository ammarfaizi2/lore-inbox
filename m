Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285165AbSALTgT>; Sat, 12 Jan 2002 14:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285229AbSALTgC>; Sat, 12 Jan 2002 14:36:02 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:6053 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S285165AbSALTfm>;
	Sat, 12 Jan 2002 14:35:42 -0500
Date: Sat, 12 Jan 2002 14:26:08 -0500
From: Scott Russell <lnxgeek@us.ibm.com>
To: linux-atm-general@lists.sourceforge.net, chas@cmf.nrl.navy.mil,
        linux-kernel@vger.kernel.org
Subject: 2.4.9 RH, ATM 0.78, Marconi HE155 kernel oops
Message-ID: <20020112142608.A27083@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: IBM Linux Technology Center
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greets.

I'm still seeing crashes from the ATM/Network code on my box. (I'm not
actually 100% of the root cause of the crash yet. Because of that, I've
attached lots of extra info to this message.)

I've tried the latest he.c code Chas provided (1.86 2001/09/30 12:17:46) by
patching it into the 2.4.9-12 errata kernel Red Hat supplies for 7.2 i386.
I've also patched in Chas's clip code rewrites for clip.c and atmclip.h. 

Attached are the following files:

    oops-decode.txt - Results of ksymoops
    atmclip.h.patch - atmclip.h patch file for review
    atmclip.h.readme - comments about atmclip.h patch
    clip.c.patch - clip.c.patch file for review
    clip.c.readme - comments about clip.c patch
    boot.txt - start up mesgs from system boot and raw oops txt
    
Anyone have any thoughts on how to fix this? 

Thanks for all the help.

-- 
Regards,
 Scott Russell (lnxgeek@us.ibm.com)
 Linux Technology Center, System Admin, RHCE.
 T/L 441-9289 / External 919-543-9289
 http://bzimage.raleigh.ibm.com/webcam


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops-decode.txt"

ksymoops 2.4.0 on i686 2.4.9-14ltc.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-14ltc/ (default)
     -m /boot/System.map-2.4.9-14ltc (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/he.o) for he
Error (expand_objects): cannot stat(/lib/ips.o) for ips
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/abi/abi.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/addon/cipe/bf-i386.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/addon/addon.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/cdrom/driver.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/char/drm-4.0/drm.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/media/radio/radio.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/media/video/video.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/media/media.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/misc/misc.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/net/appletalk/appletalk.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/net/fc/fc.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/net/pcmcia/pcmcia_net.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/net/tokenring/tr.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/net/wan/wan.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/net/wireless/wireless_net.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/parport/driver.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/drivers/sound/sounddrivers.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/net/ipv4/netfilter/netfilter.o
Warning (read_object): no symbols in /lib/modules/2.4.9-14ltc/build/net/ipv6/netfilter/netfilter.o
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01c0b00, System.map says c01600a0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says f8a40060, /lib/modules/2.4.9-14ltc/kernel/drivers/usb/usbcore.o says f8a3fb80.  Ignoring /lib/modules/2.4.9-14ltc/kernel/drivers/usb/usbcore.o entry
Warning (map_ksym_to_module): cannot match loaded module he to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module ips to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module sd_mod to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module scsi_mod to a unique module object.  Trace may not be reliable.
Unable to handle kernel NULL pointer dereference at virtual address 00000008
c02190cf
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c02190cf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000001   ebx: eea5b4a0   ecx: ef822f88   edx: 00000000
esi: 00000206   edi: f10dc33c   ebp: f10dc800   esp: f7ff9c40
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=f7ff9000)
Stack: ef822f88 f10dc800 c0219140 f10dc800 ef898580 e5c0e980 ef9d13a0 f10dc200 
       e5c0e980 c01d6b29 e5c0e980 f10dc200 f10dc200 00000000 ef9d13a0 c01d6ad4 
       00000000 f10dc200 f7ff8000 c01ce88e f10dc200 00000000 f10dc200 f10dc200 
Call Trace: [<c0219140>] clip_start_xmit [kernel] 0x2b0 
[<c01d6b29>] qdisc_restart [kernel] 0x69 
[<c01d6ad4>] qdisc_restart [kernel] 0x14 
[<c01ce88e>] dev_queue_xmit [kernel] 0xee 
[<c01ce88e>] dev_queue_xmit [kernel] 0xee 
[<c01e25c3>] ip_output [kernel] 0x113 
[<c01e25c3>] ip_output [kernel] 0x113 
[<c01e299b>] ip_queue_xmit [kernel] 0x38b 
[<c01f6b4e>] tcp_v4_send_check [kernel] 0x6e 
[<c01f19f5>] tcp_transmit_skb [kernel] 0x565 
[<c01f24a7>] tcp_write_xmit [kernel] 0x157 
[<c01ef942>] __tcp_data_snd_check [kernel] 0x52 
[<c01cb029>] __kfree_skb [kernel] 0x129 
[<c01efda6>] tcp_rcv_established [kernel] 0xe6 
[<c01cbf3c>] skb_checksum [kernel] 0x4c 
[<c01f7ac4>] tcp_v4_do_rcv [kernel] 0x94 
[<c01f79ab>] tcp_v4_checksum_init [kernel] 0x6b 
[<c01f7fbe>] tcp_v4_rcv [kernel] 0x3fe 
[<c01ceb4c>] netif_rx [kernel] 0x8c 
[<c01df94b>] ip_local_deliver [kernel] 0x12b 
[<c01dfd37>] ip_rcv [kernel] 0x357 
[<f882c7e8>] __insmod_he_S.text_L18288 [he] 0x2788 
[<c01ceffb>] net_rx_action [kernel] 0x1eb 
[<c011f72c>] tasklet_action [kernel] 0x6c 
[<c011f54b>] do_softirq [kernel] 0x7b 
[<c0108c4d>] do_IRQ [kernel] 0xdd 
[<c0105410>] default_idle [kernel] 0x0 
[<c0105410>] default_idle [kernel] 0x0 
[<c0227a38>] call_do_IRQ [kernel] 0x5 
[<c0105410>] default_idle [kernel] 0x0 
[<c0105410>] default_idle [kernel] 0x0 
[<c010543d>] default_idle [kernel] 0x2d 
[<c01054c2>] cpu_idle [kernel] 0x52 
[<c011b296>] __call_console_drivers [kernel] 0x46 
[<c011b40b>] call_console_drivers [kernel] 0xeb 
Code: 87 42 08 85 c0 74 1a c6 47 04 01 56 9d 68 80 51 26 c0 e8 aa 

>>EIP; c02190cf <clip_start_xmit+23f/2c0>   <=====
Trace; c0219140 <clip_start_xmit+2b0/2c0>
Trace; c01d6b29 <qdisc_restart+69/170>
Trace; c01d6ad4 <qdisc_restart+14/170>
Trace; c01ce88e <dev_queue_xmit+ee/2c0>
Trace; c01ce88e <dev_queue_xmit+ee/2c0>
Trace; c01e25c3 <ip_output+113/160>
Trace; c01e25c3 <ip_output+113/160>
Trace; c01e299b <ip_queue_xmit+38b/4d0>
Trace; c01f6b4e <tcp_v4_send_check+6e/b0>
Trace; c01f19f5 <tcp_transmit_skb+565/620>
Trace; c01f24a7 <tcp_write_xmit+157/290>
Trace; c01ef942 <__tcp_data_snd_check+52/d0>
Trace; c01cb029 <__kfree_skb+129/130>
Trace; c01efda6 <tcp_rcv_established+e6/7e0>
Trace; c01cbf3c <skb_checksum+4c/220>
Trace; c01f7ac4 <tcp_v4_do_rcv+94/190>
Trace; c01f79ab <tcp_v4_checksum_init+6b/f0>
Trace; c01f7fbe <tcp_v4_rcv+3fe/670>
Trace; c01ceb4c <netif_rx+8c/100>
Trace; c01df94b <ip_local_deliver+12b/1c0>
Trace; c01dfd37 <ip_rcv+357/3f0>
Trace; f882c7e8 <[he].text.start+2788/476f>
Trace; c01ceffb <net_rx_action+1eb/300>
Trace; c011f72c <tasklet_action+6c/a0>
Trace; c011f54b <do_softirq+7b/e0>
Trace; c0108c4d <do_IRQ+dd/f0>
Trace; c0105410 <default_idle+0/40>
Trace; c0105410 <default_idle+0/40>
Trace; c0227a38 <call_do_IRQ+5/d>
Trace; c0105410 <default_idle+0/40>
Trace; c0105410 <default_idle+0/40>
Trace; c010543d <default_idle+2d/40>
Trace; c01054c2 <cpu_idle+52/70>
Trace; c011b296 <__call_console_drivers+46/60>
Trace; c011b40b <call_console_drivers+eb/100>
Code;  c02190cf <clip_start_xmit+23f/2c0>
00000000 <_EIP>:
Code;  c02190cf <clip_start_xmit+23f/2c0>   <=====
   0:   87 42 08                  xchg   %eax,0x8(%edx)   <=====
Code;  c02190d2 <clip_start_xmit+242/2c0>
   3:   85 c0                     test   %eax,%eax
Code;  c02190d4 <clip_start_xmit+244/2c0>
   5:   74 1a                     je     21 <_EIP+0x21> c02190f0 <clip_start_xmit+260/2c0>
Code;  c02190d6 <clip_start_xmit+246/2c0>
   7:   c6 47 04 01               movb   $0x1,0x4(%edi)
Code;  c02190da <clip_start_xmit+24a/2c0>
   b:   56                        push   %esi
Code;  c02190db <clip_start_xmit+24b/2c0>
   c:   9d                        popf   
Code;  c02190dc <clip_start_xmit+24c/2c0>
   d:   68 80 51 26 c0            push   $0xc0265180
Code;  c02190e1 <clip_start_xmit+251/2c0>
  12:   e8 aa 00 00 00            call   c1 <_EIP+0xc1> c0219190 <clip_mkip+30/170>

 <0>Kernel panic: Aiee, killing interrupt handler!

26 warnings and 4 errors issued.  Results may not be reliable.

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atmclip.h.patch"

--- atmclip.h.orig	Tue Oct 16 10:34:43 2001
+++ atmclip.h	Tue Oct 16 10:35:13 2001
@@ -23,7 +23,7 @@
 	struct atm_vcc	*vcc;		/* VCC descriptor */
 	struct atmarp_entry *entry;	/* ATMARP table entry, NULL if IP addr.
 					   isn't known yet */
-	int		xoff;		/* 1 if send buffer is full */
+	volatile int	xoff;		/* 1 if send buffer is full */
 	unsigned char	encap;		/* 0: NULL, 1: LLC/SNAP */
 	unsigned long	last_use;	/* last send or receive operation */
 	unsigned long	idle_timeout;	/* keep open idle for so many jiffies*/

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atmclip.h.readme"

>From Chas:

we had a little power problem on saturday afternoon so i havent been
wasnt able to reply earlier until i went in today and 'fixed' the problem.
but, after some thought, i think ->xoff should probably be volatile.
[see the attached patch].  eric picked up the 2nd edition of linux
device driver programming and the interrupt chapter is fairly useful.
see page 278, 'race conditions'   since xoff is set to 1 in only one
place it seems likely that this is a race condition.  clip_pop()
unsets ->xoff but after xmit_start exits, it resets xoff back to 1.
of course, the clip code cant recover from this situation either.
i think the flow control for clip could be cleaner.  like

. spin_lock on xoff_lock before changing xoff always or change xoff to
  atomic_t (is xchg() atomic?  i cant find any docs on it)
. stop the netif_queue BEFORE sending the pdu to the card driver
. allow clip to recover from XOFF->XOFF conditions
 

  

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="clip.c.patch"

--- clip.c.orig	Wed Oct 17 10:39:30 2001
+++ clip.c	Wed Oct 17 10:51:46 2001
@@ -431,28 +431,22 @@
 	ATM_SKB(skb)->atm_options = vcc->atm_options;
 	entry->vccs->last_use = jiffies;
 	DPRINTK("atm_skb(%p)->vcc(%p)->dev(%p)\n",skb,vcc,vcc->dev);
+	spin_lock_irqsave(&clip_priv->xoff_lock,flags);
 	old = xchg(&entry->vccs->xoff,1); /* assume XOFF ... */
 	if (old) {
+		spin_unlock_irqrestore(&clip_priv->xoff_lock,flags);
 		printk(KERN_WARNING "clip_start_xmit: XOFF->XOFF transition\n");
 		return 0;
 	}
+	if (atm_may_send(vcc,0))
+		entry->vccs->xoff = 0;
+	else
+		netif_stop_queue(dev); /* XOFF -> throttle immediately */
+	spin_unlock_irqrestore(&clip_priv->xoff_lock,flags);
+
 	clip_priv->stats.tx_packets++;
 	clip_priv->stats.tx_bytes += skb->len;
 	(void) vcc->send(vcc,skb);
-	if (atm_may_send(vcc,0)) {
-		entry->vccs->xoff = 0;
-		return 0;
-	}
-	spin_lock_irqsave(&clip_priv->xoff_lock,flags);
-	netif_stop_queue(dev); /* XOFF -> throttle immediately */
-	barrier();
-	if (!entry->vccs->xoff)
-		netif_start_queue(dev);
-		/* Oh, we just raced with clip_pop. netif_start_queue should be
-		   good enough, because nothing should really be asleep because
-		   of the brief netif_stop_queue. If this isn't true or if it
-		   changes, use netif_wake_queue instead. */
-	spin_unlock_irqrestore(&clip_priv->xoff_lock,flags);
 	return 0;
 }
 
--- clip.c.orig	Thu Nov  1 15:58:37 2001
+++ clip.c	Thu Nov  1 16:10:53 2001
@@ -422,6 +422,29 @@
 	if (entry->vccs->encap) {
 		void *here;
 
+		/* Mitchell Blank's patch to fix ping over IPSEC problems. */
+		/* "The bug is that clip_start_xmit does a skb_push without verifying that
+		   there is sufficient space in the skb's headroom for the 1483 encapsulation.
+		   Normally this isn't a problem since all skb's are born with 16 bytes of
+		   headroom (under "normal" circumstances ethernet uses 14 and 2 are wasted
+		   for alignment - since we don't need an ethernet header we usually will have
+	           plenty of space) but in this case IPSec has already taken most of the
+		   headroom so we need to make more before tacking on our own header." */
+
+                if (skb_headroom(skb) < RFC1483LLC_LEN || skb_cloned(skb) || skb_shared(skb)) {
+                        struct sk_buff *skb2 = skb_realloc_headroom(skb,RFC1483LLC_LEN);
+                        if (!skb2) {
+                                clip_priv->stats.tx_dropped++;
+                                dev_kfree_skb(skb);
+                                return 0;
+                        }
+                        /* Not sure about these next two lines, actually... */
+                        if (skb->sk) skb_set_owner_w(skb2, skb->sk);
+                        dev_kfree_skb(skb);
+                        skb = skb2;
+                }
+		/* End Patch */
+
 		here = skb_push(skb,RFC1483LLC_LEN);
 		memcpy(here,llc_oui,sizeof(llc_oui));
 		((u16 *) here)[3] = skb->protocol;

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="clip.c.readme"

Chas writes:

could you try this patch as well as the other?  it should remove the
race condition that exists in the current code.  in the old code, the
atm_may_send check is after the send.  this is racing with the clip_pop
which will occur right after the downcall to the driver's send (atleast
the he driver works this way, its trying to free those outstanding skb's
as soon as possible)  if we do the work before the down call this should
help some.  i also moved the xoff_lock to protect xoff and the
netif_queue calls.  you really want these to occur together w/o
clip_pop interrupting.


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot.txt"

Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c02190cf
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c02190cf>]    Not tainted
EFLAGS: 00010046
eax: 00000001   ebx: eea5b4a0   ecx: ef822f88   edx: 00000000
esi: 00000206   edi: f10dc33c   ebp: f10dc800   esp: f7ff9c40
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=f7ff9000)
Stack: ef822f88 f10dc800 c0219140 f10dc800 ef898580 e5c0e980 ef9d13a0 f10dc200 
       e5c0e980 c01d6b29 e5c0e980 f10dc200 f10dc200 00000000 ef9d13a0 c01d6ad4 
       00000000 f10dc200 f7ff8000 c01ce88e f10dc200 00000000 f10dc200 f10dc200 
Call Trace: [<c0219140>] clip_start_xmit [kernel] 0x2b0 
[<c01d6b29>] qdisc_restart [kernel] 0x69 
[<c01d6ad4>] qdisc_restart [kernel] 0x14 
[<c01ce88e>] dev_queue_xmit [kernel] 0xee 
[<c01ce88e>] dev_queue_xmit [kernel] 0xee 
[<c01e25c3>] ip_output [kernel] 0x113 
[<c01e25c3>] ip_output [kernel] 0x113 
[<c01e299b>] ip_queue_xmit [kernel] 0x38b 
[<c01f6b4e>] tcp_v4_send_check [kernel] 0x6e 
[<c01f19f5>] tcp_transmit_skb [kernel] 0x565 
[<c01f24a7>] tcp_write_xmit [kernel] 0x157 
[<c01ef942>] __tcp_data_snd_check [kernel] 0x52 
[<c01cb029>] __kfree_skb [kernel] 0x129 
[<c01efda6>] tcp_rcv_established [kernel] 0xe6 
[<c01cbf3c>] skb_checksum [kernel] 0x4c 
[<c01f7ac4>] tcp_v4_do_rcv [kernel] 0x94 
[<c01f79ab>] tcp_v4_checksum_init [kernel] 0x6b 
[<c01f7fbe>] tcp_v4_rcv [kernel] 0x3fe 
[<c01ceb4c>] netif_rx [kernel] 0x8c 
[<c01df94b>] ip_local_deliver [kernel] 0x12b 
[<c01dfd37>] ip_rcv [kernel] 0x357 
[<f882c7e8>] __insmod_he_S.text_L18288 [he] 0x2788 
[<c01ceffb>] net_rx_action [kernel] 0x1eb 
[<c011f72c>] tasklet_action [kernel] 0x6c 
[<c011f54b>] do_softirq [kernel] 0x7b 
[<c0108c4d>] do_IRQ [kernel] 0xdd 
[<c0105410>] default_idle [kernel] 0x0 
[<c0105410>] default_idle [kernel] 0x0 
[<c0227a38>] call_do_IRQ [kernel] 0x5 
[<c0105410>] default_idle [kernel] 0x0 
[<c0105410>] default_idle [kernel] 0x0 
[<c010543d>] default_idle [kernel] 0x2d 
[<c01054c2>] cpu_idle [kernel] 0x52 
[<c011b296>] __call_console_drivers [kernel] 0x46 
[<c011b40b>] call_console_drivers [kernel] 0xeb 


Code: 87 42 08 85 c0 74 1a c6 47 04 01 56 9d 68 80 51 26 c0 e8 aa 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 

--0OAP2g/MAC+5xKAE--
