Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752601AbWAHFvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbWAHFvc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 00:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbWAHFvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 00:51:31 -0500
Received: from xenotime.net ([66.160.160.81]:7115 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752602AbWAHFv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 00:51:28 -0500
Date: Sat, 7 Jan 2006 21:51:25 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, davem@davemloft.net
Subject: [PATCH 3/4] capable/capability.h (net/)
Message-Id: <20060107215125.3ccb2f2c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

net: Use <linux/capability.h> where capable() is used.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 net/8021q/vlan.c                |    1 +
 net/appletalk/ddp.c             |    1 +
 net/atm/br2684.c                |    1 +
 net/atm/clip.c                  |    1 +
 net/atm/ioctl.c                 |    1 +
 net/atm/lec.c                   |    1 +
 net/atm/mpc.c                   |    1 +
 net/atm/pppoatm.c               |    1 +
 net/atm/raw.c                   |    1 +
 net/atm/resources.c             |    1 +
 net/ax25/af_ax25.c              |    1 +
 net/ax25/ax25_route.c           |    2 ++
 net/ax25/ax25_uid.c             |    2 ++
 net/bluetooth/bnep/sock.c       |    1 +
 net/bluetooth/cmtp/sock.c       |    1 +
 net/bluetooth/hci_sock.c        |    1 +
 net/bluetooth/hidp/sock.c       |    1 +
 net/bluetooth/l2cap.c           |    1 +
 net/bluetooth/rfcomm/tty.c      |    1 +
 net/bridge/br_ioctl.c           |    1 +
 net/bridge/br_sysfs_br.c        |    1 +
 net/bridge/br_sysfs_if.c        |    1 +
 net/core/dev.c                  |    1 +
 net/core/dv.c                   |    1 +
 net/core/ethtool.c              |    1 +
 net/core/net-sysfs.c            |    1 +
 net/core/pktgen.c               |    2 +-
 net/core/scm.c                  |    1 +
 net/core/sock.c                 |    1 +
 net/decnet/af_decnet.c          |    1 +
 net/decnet/dn_dev.c             |    1 +
 net/ipv4/af_inet.c              |    1 +
 net/ipv4/arp.c                  |    1 +
 net/ipv4/devinet.c              |    1 +
 net/ipv4/fib_frontend.c         |    1 +
 net/ipv4/ip_gre.c               |    1 +
 net/ipv4/ip_options.c           |    1 +
 net/ipv4/ipip.c                 |    1 +
 net/ipv4/ipmr.c                 |    1 +
 net/ipv4/ipvs/ip_vs_ctl.c       |    1 +
 net/ipv4/netfilter/arp_tables.c |    1 +
 net/ipv4/netfilter/ip_tables.c  |    1 +
 net/ipv6/addrconf.c             |    1 +
 net/ipv6/af_inet6.c             |    1 +
 net/ipv6/anycast.c              |    1 +
 net/ipv6/datagram.c             |    1 +
 net/ipv6/ip6_flowlabel.c        |    1 +
 net/ipv6/ip6_tunnel.c           |    1 +
 net/ipv6/ipv6_sockglue.c        |    1 +
 net/ipv6/netfilter/ip6_tables.c |    2 ++
 net/ipv6/route.c                |    1 +
 net/ipv6/sit.c                  |    1 +
 net/ipx/af_ipx.c                |    1 +
 net/irda/af_irda.c              |    1 +
 net/irda/irda_device.c          |    1 +
 net/irda/irnet/irnet.h          |    1 +
 net/key/af_key.c                |    1 +
 net/netlink/af_netlink.c        |    1 +
 net/netrom/af_netrom.c          |    1 +
 net/packet/af_packet.c          |    1 +
 net/rose/af_rose.c              |    2 ++
 net/sctp/socket.c               |    1 +
 net/wanrouter/af_wanpipe.c      |    1 +
 net/wanrouter/wanmain.c         |    1 +
 net/x25/af_x25.c                |    1 +
 65 files changed, 69 insertions(+), 1 deletion(-)

--- linux-2615-g3.orig/net/8021q/vlan.c
+++ linux-2615-g3/net/8021q/vlan.c
@@ -19,6 +19,7 @@
  */
 
 #include <asm/uaccess.h> /* for copy_from_user */
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
--- linux-2615-g3.orig/net/appletalk/ddp.c
+++ linux-2615-g3/net/appletalk/ddp.c
@@ -52,6 +52,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/if_arp.h>
 #include <linux/termios.h>	/* For TIOCOUTQ/INQ */
--- linux-2615-g3.orig/net/ax25/af_ax25.c
+++ linux-2615-g3/net/ax25/af_ax25.c
@@ -14,6 +14,7 @@
  * Copyright (C) Frederic Rible F1OAT (frible@teaser.fr)
  */
 #include <linux/config.h>
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/types.h>
--- linux-2615-g3.orig/net/ax25/ax25_route.c
+++ linux-2615-g3/net/ax25/ax25_route.c
@@ -11,6 +11,8 @@
  * Copyright (C) Hans-Joachim Hetscher DD8NE (dd8ne@bnv-bamberg.de)
  * Copyright (C) Frederic Rible F1OAT (frible@teaser.fr)
  */
+
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/socket.h>
--- linux-2615-g3.orig/net/ax25/ax25_uid.c
+++ linux-2615-g3/net/ax25/ax25_uid.c
@@ -6,6 +6,8 @@
  *
  * Copyright (C) Jonathan Naylor G4KLX (g4klx@g4klx.demon.co.uk)
  */
+
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/socket.h>
--- linux-2615-g3.orig/net/bridge/br_ioctl.c
+++ linux-2615-g3/net/bridge/br_ioctl.c
@@ -13,6 +13,7 @@
  *	2 of the License, or (at your option) any later version.
  */
 
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/if_bridge.h>
 #include <linux/netdevice.h>
--- linux-2615-g3.orig/net/bridge/br_sysfs_br.c
+++ linux-2615-g3/net/bridge/br_sysfs_br.c
@@ -11,6 +11,7 @@
  *	2 of the License, or (at your option) any later version.
  */
 
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/if_bridge.h>
--- linux-2615-g3.orig/net/bridge/br_sysfs_if.c
+++ linux-2615-g3/net/bridge/br_sysfs_if.c
@@ -11,6 +11,7 @@
  *	2 of the License, or (at your option) any later version.
  */
 
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/if_bridge.h>
--- linux-2615-g3.orig/net/decnet/af_decnet.c
+++ linux-2615-g3/net/decnet/af_decnet.c
@@ -122,6 +122,7 @@ Version 0.0.6    2.1.110   07-aug-98   E
 #include <net/flow.h>
 #include <asm/system.h>
 #include <asm/ioctls.h>
+#include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/proc_fs.h>
--- linux-2615-g3.orig/net/decnet/dn_dev.c
+++ linux-2615-g3/net/decnet/dn_dev.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
--- linux-2615-g3.orig/net/ipx/af_ipx.c
+++ linux-2615-g3/net/ipx/af_ipx.c
@@ -29,6 +29,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
--- linux-2615-g3.orig/net/irda/af_irda.c
+++ linux-2615-g3/net/irda/af_irda.c
@@ -43,6 +43,7 @@
  ********************************************************************/
 
 #include <linux/config.h>
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/socket.h>
--- linux-2615-g3.orig/net/irda/irda_device.c
+++ linux-2615-g3/net/irda/irda_device.c
@@ -33,6 +33,7 @@
 #include <linux/string.h>
 #include <linux/proc_fs.h>
 #include <linux/skbuff.h>
+#include <linux/capability.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
--- linux-2615-g3.orig/net/irda/irnet/irnet.h
+++ linux-2615-g3/net/irda/irnet/irnet.h
@@ -248,6 +248,7 @@
 #include <linux/netdevice.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/ctype.h>	/* isspace() */
 #include <asm/uaccess.h>
--- linux-2615-g3.orig/net/key/af_key.c
+++ linux-2615-g3/net/key/af_key.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/socket.h>
--- linux-2615-g3.orig/net/netlink/af_netlink.c
+++ linux-2615-g3/net/netlink/af_netlink.c
@@ -24,6 +24,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/signal.h>
--- linux-2615-g3.orig/net/netrom/af_netrom.c
+++ linux-2615-g3/net/netrom/af_netrom.c
@@ -11,6 +11,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/socket.h>
--- linux-2615-g3.orig/net/packet/af_packet.c
+++ linux-2615-g3/net/packet/af_packet.c
@@ -53,6 +53,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/capability.h>
 #include <linux/fcntl.h>
 #include <linux/socket.h>
 #include <linux/in.h>
--- linux-2615-g3.orig/net/rose/af_rose.c
+++ linux-2615-g3/net/rose/af_rose.c
@@ -9,7 +9,9 @@
  * Copyright (C) Terry Dawson VK2KTJ (terry@animats.net)
  * Copyright (C) Tomi Manninen OH2BNS (oh2bns@sral.fi)
  */
+
 #include <linux/config.h>
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
--- linux-2615-g3.orig/net/sctp/socket.c
+++ linux-2615-g3/net/sctp/socket.c
@@ -63,6 +63,7 @@
 #include <linux/wait.h>
 #include <linux/time.h>
 #include <linux/ip.h>
+#include <linux/capability.h>
 #include <linux/fcntl.h>
 #include <linux/poll.h>
 #include <linux/init.h>
--- linux-2615-g3.orig/net/wanrouter/af_wanpipe.c
+++ linux-2615-g3/net/wanrouter/af_wanpipe.c
@@ -36,6 +36,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/capability.h>
 #include <linux/fcntl.h>
 #include <linux/socket.h>
 #include <linux/in.h>
--- linux-2615-g3.orig/net/wanrouter/wanmain.c
+++ linux-2615-g3/net/wanrouter/wanmain.c
@@ -44,6 +44,7 @@
 
 #include <linux/config.h>
 #include <linux/stddef.h>	/* offsetof(), etc. */
+#include <linux/capability.h>
 #include <linux/errno.h>	/* return codes */
 #include <linux/kernel.h>
 #include <linux/init.h>
--- linux-2615-g3.orig/net/x25/af_x25.c
+++ linux-2615-g3/net/x25/af_x25.c
@@ -37,6 +37,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
--- linux-2615-g3.orig/net/atm/br2684.c
+++ linux-2615-g3/net/atm/br2684.c
@@ -18,6 +18,7 @@ Author: Marcell GAL, 2000, XDSL Ltd, Hun
 #include <net/arp.h>
 #include <linux/atm.h>
 #include <linux/atmdev.h>
+#include <linux/capability.h>
 #include <linux/seq_file.h>
 
 #include <linux/atmbr2684.h>
--- linux-2615-g3.orig/net/atm/clip.c
+++ linux-2615-g3/net/atm/clip.c
@@ -19,6 +19,7 @@
 #include <linux/atmdev.h>
 #include <linux/atmclip.h>
 #include <linux/atmarp.h>
+#include <linux/capability.h>
 #include <linux/ip.h> /* for net/route.h */
 #include <linux/in.h> /* for struct sockaddr_in */
 #include <linux/if.h> /* for IFF_UP */
--- linux-2615-g3.orig/net/atm/ioctl.c
+++ linux-2615-g3/net/atm/ioctl.c
@@ -12,6 +12,7 @@
 #include <linux/atmdev.h>
 #include <linux/atmclip.h>	/* CLIP_*ENCAP */
 #include <linux/atmarp.h>	/* manifest constants */
+#include <linux/capability.h>
 #include <linux/sonet.h>	/* for ioctls */
 #include <linux/atmsvc.h>
 #include <linux/atmmpc.h>
--- linux-2615-g3.orig/net/atm/lec.c
+++ linux-2615-g3/net/atm/lec.c
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/capability.h>
 
 /* We are ethernet device */
 #include <linux/if_ether.h>
--- linux-2615-g3.orig/net/atm/mpc.c
+++ linux-2615-g3/net/atm/mpc.c
@@ -3,6 +3,7 @@
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/bitops.h>
+#include <linux/capability.h>
 #include <linux/seq_file.h>
 
 /* We are an ethernet device */
--- linux-2615-g3.orig/net/atm/pppoatm.c
+++ linux-2615-g3/net/atm/pppoatm.c
@@ -39,6 +39,7 @@
 #include <linux/skbuff.h>
 #include <linux/atm.h>
 #include <linux/atmdev.h>
+#include <linux/capability.h>
 #include <linux/ppp_defs.h>
 #include <linux/if_ppp.h>
 #include <linux/ppp_channel.h>
--- linux-2615-g3.orig/net/atm/raw.c
+++ linux-2615-g3/net/atm/raw.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/atmdev.h>
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
 #include <linux/mm.h>
--- linux-2615-g3.orig/net/atm/resources.c
+++ linux-2615-g3/net/atm/resources.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h> /* for barrier */
 #include <linux/module.h>
 #include <linux/bitops.h>
+#include <linux/capability.h>
 #include <linux/delay.h>
 #include <net/sock.h>	 /* for struct sock */
 
--- linux-2615-g3.orig/net/bluetooth/bnep/sock.c
+++ linux-2615-g3/net/bluetooth/bnep/sock.c
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 
 #include <linux/types.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
--- linux-2615-g3.orig/net/bluetooth/cmtp/sock.c
+++ linux-2615-g3/net/bluetooth/cmtp/sock.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 
 #include <linux/types.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
--- linux-2615-g3.orig/net/bluetooth/hci_sock.c
+++ linux-2615-g3/net/bluetooth/hci_sock.c
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 
 #include <linux/types.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
--- linux-2615-g3.orig/net/bluetooth/hidp/sock.c
+++ linux-2615-g3/net/bluetooth/hidp/sock.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 
 #include <linux/types.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
--- linux-2615-g3.orig/net/bluetooth/l2cap.c
+++ linux-2615-g3/net/bluetooth/l2cap.c
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 
 #include <linux/types.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
--- linux-2615-g3.orig/net/bluetooth/rfcomm/tty.c
+++ linux-2615-g3/net/bluetooth/rfcomm/tty.c
@@ -34,6 +34,7 @@
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
 
+#include <linux/capability.h>
 #include <linux/slab.h>
 #include <linux/skbuff.h>
 
--- linux-2615-g3.orig/net/core/dev.c
+++ linux-2615-g3/net/core/dev.c
@@ -75,6 +75,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <linux/bitops.h>
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/cpu.h>
 #include <linux/types.h>
--- linux-2615-g3.orig/net/core/dv.c
+++ linux-2615-g3/net/core/dv.c
@@ -24,6 +24,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <net/dst.h>
--- linux-2615-g3.orig/net/core/ethtool.c
+++ linux-2615-g3/net/core/ethtool.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
--- linux-2615-g3.orig/net/core/net-sysfs.c
+++ linux-2615-g3/net/core/net-sysfs.c
@@ -9,6 +9,7 @@
  *	2 of the License, or (at your option) any later version.
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
--- linux-2615-g3.orig/net/core/pktgen.c
+++ linux-2615-g3/net/core/pktgen.c
@@ -116,13 +116,13 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/sched.h>
 #include <linux/unistd.h>
 #include <linux/string.h>
 #include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
+#include <linux/capability.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/init.h>
--- linux-2615-g3.orig/net/core/scm.c
+++ linux-2615-g3/net/core/scm.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/signal.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
--- linux-2615-g3.orig/net/core/sock.c
+++ linux-2615-g3/net/core/sock.c
@@ -91,6 +91,7 @@
  *		2 of the License, or (at your option) any later version.
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/types.h>
--- linux-2615-g3.orig/net/ipv4/af_inet.c
+++ linux-2615-g3/net/ipv4/af_inet.c
@@ -79,6 +79,7 @@
 #include <linux/string.h>
 #include <linux/sockios.h>
 #include <linux/net.h>
+#include <linux/capability.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
--- linux-2615-g3.orig/net/ipv4/arp.c
+++ linux-2615-g3/net/ipv4/arp.c
@@ -79,6 +79,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/socket.h>
 #include <linux/sockios.h>
--- linux-2615-g3.orig/net/ipv4/devinet.c
+++ linux-2615-g3/net/ipv4/devinet.c
@@ -32,6 +32,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <linux/bitops.h>
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
--- linux-2615-g3.orig/net/ipv4/fib_frontend.c
+++ linux-2615-g3/net/ipv4/fib_frontend.c
@@ -20,6 +20,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <linux/bitops.h>
+#include <linux/capability.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
--- linux-2615-g3.orig/net/ipv4/ip_gre.c
+++ linux-2615-g3/net/ipv4/ip_gre.c
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/types.h>
--- linux-2615-g3.orig/net/ipv4/ip_options.c
+++ linux-2615-g3/net/ipv4/ip_options.c
@@ -11,6 +11,7 @@
  *		
  */
 
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <asm/uaccess.h>
--- linux-2615-g3.orig/net/ipv4/ipip.c
+++ linux-2615-g3/net/ipv4/ipip.c
@@ -93,6 +93,7 @@
  */
 
  
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/types.h>
--- linux-2615-g3.orig/net/ipv4/ipmr.c
+++ linux-2615-g3/net/ipv4/ipmr.c
@@ -33,6 +33,7 @@
 #include <asm/uaccess.h>
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
--- linux-2615-g3.orig/net/ipv4/ipvs/ip_vs_ctl.c
+++ linux-2615-g3/net/ipv4/ipvs/ip_vs_ctl.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
--- linux-2615-g3.orig/net/ipv4/netfilter/arp_tables.c
+++ linux-2615-g3/net/ipv4/netfilter/arp_tables.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/capability.h>
 #include <linux/if_arp.h>
 #include <linux/kmod.h>
 #include <linux/vmalloc.h>
--- linux-2615-g3.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2615-g3/net/ipv4/netfilter/ip_tables.c
@@ -14,6 +14,7 @@
  */
 #include <linux/config.h>
 #include <linux/cache.h>
+#include <linux/capability.h>
 #include <linux/skbuff.h>
 #include <linux/kmod.h>
 #include <linux/vmalloc.h>
--- linux-2615-g3.orig/net/ipv6/addrconf.c
+++ linux-2615-g3/net/ipv6/addrconf.c
@@ -58,6 +58,7 @@
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif
+#include <linux/capability.h>
 #include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/string.h>
--- linux-2615-g3.orig/net/ipv6/af_inet6.c
+++ linux-2615-g3/net/ipv6/af_inet6.c
@@ -22,6 +22,7 @@
 
 
 #include <linux/module.h>
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/types.h>
--- linux-2615-g3.orig/net/ipv6/anycast.c
+++ linux-2615-g3/net/ipv6/anycast.c
@@ -13,6 +13,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
--- linux-2615-g3.orig/net/ipv6/datagram.c
+++ linux-2615-g3/net/ipv6/datagram.c
@@ -13,6 +13,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
--- linux-2615-g3.orig/net/ipv6/ip6_flowlabel.c
+++ linux-2615-g3/net/ipv6/ip6_flowlabel.c
@@ -9,6 +9,7 @@
  *	Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/types.h>
--- linux-2615-g3.orig/net/ipv6/ip6_tunnel.c
+++ linux-2615-g3/net/ipv6/ip6_tunnel.c
@@ -21,6 +21,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/sockios.h>
--- linux-2615-g3.orig/net/ipv6/ipv6_sockglue.c
+++ linux-2615-g3/net/ipv6/ipv6_sockglue.c
@@ -26,6 +26,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/types.h>
--- linux-2615-g3.orig/net/ipv6/netfilter/ip6_tables.c
+++ linux-2615-g3/net/ipv6/netfilter/ip6_tables.c
@@ -14,6 +14,8 @@
  * 06 Jun 2002 Andras Kis-Szabo <kisza@sch.bme.hu>
  *      - new extension header parser code
  */
+
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/in.h>
 #include <linux/skbuff.h>
--- linux-2615-g3.orig/net/ipv6/route.c
+++ linux-2615-g3/net/ipv6/route.c
@@ -24,6 +24,7 @@
  *		reachable.  otherwise, round-robin the list.
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/types.h>
--- linux-2615-g3.orig/net/ipv6/sit.c
+++ linux-2615-g3/net/ipv6/sit.c
@@ -20,6 +20,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/socket.h>


---
