Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965685AbWKDUwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965685AbWKDUwE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965687AbWKDUwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:52:04 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:58053 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965685AbWKDUwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:52:02 -0500
Message-id: <1202725131414221392@wsc.cz>
In-reply-to: <453BA26D.9010504@trash.net>
References: <453BA26D.9010504@trash.net>, <43123154321532@wsc.cz>
Subject: [PATCH 1/1] Net: kconfig, correct traffic shaper
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@redhat.com>
Cc: Patrick McHardy <kaber@trash.net>
Cc: <netdev@vger.kernel.org>
Cc: <jgarzik@pobox.com>
Date: Sat,  4 Nov 2006 21:52:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy <kaber@trash.net> wrote:
> While you're at it .. CBQ is actually not a very good alternative
> since it doesn't work properly on top of virtual network devices.
> The closest match for an alternative would be TBF, but HTB and
> HFSC also do fine. Maybe just point to the traffic schedulers in
> general. I think you could also change EXPERIMENTAL to OBSOLETE
> for the shaper device, the traffic schedulers are a lot more
> flexible.

Ok, thanks for comments. Here it comes, please (n)ack it:

--

kconfig, correct traffic shaper

As Patrick McHardy <kaber@trash.net> suggested, Traffic Shaper is
now obsolete and alternative to it is no longer CBQ, since its problems with
virtual devices, alter Kconfig text to reflect this -- put a link to the
traffic schedulers as a whole.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@redhat.com>
Cc: Patrick McHardy <kaber@trash.net>

---
commit 95045e128e4db8cc07b9a616e6c1f3606b3b499f
tree 3e924080ba76042c93e687a156483d6279e961ed
parent 7e8fb7980d776e6a7c0bd84cc48b1cb9de139b8f
author Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 21:41:33 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 21:41:33 +0059

 drivers/net/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ee5ce6b..2ede616 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2847,7 +2847,7 @@ config NET_FC
 	  "SCSI generic support".
 
 config SHAPER
-	tristate "Traffic Shaper (EXPERIMENTAL)"
+	tristate "Traffic Shaper (OBSOLETE)"
 	depends on EXPERIMENTAL
 	---help---
 	  The traffic shaper is a virtual network device that allows you to
@@ -2856,9 +2856,9 @@ config SHAPER
 	  these virtual devices. See
 	  <file:Documentation/networking/shaper.txt> for more information.
 
-	  An alternative to this traffic shaper is the experimental
-	  Class-Based Queuing (CBQ) scheduling support which you get if you
-	  say Y to "QoS and/or fair queuing" above.
+	  An alternative to this traffic shaper are traffic schedulers which
+	  you'll get if you say Y to "QoS and/or fair queuing" in
+	  "Networking options".
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called shaper.  If unsure, say N.
