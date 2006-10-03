Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWJCN4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWJCN4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 09:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWJCN4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 09:56:39 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:61710 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1750825AbWJCN4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 09:56:38 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: linux-kernel@vger.kernel.org, orinoco-devel@lists.sourceforge.net
Subject: [WIFI] problems with Enterasys Roamabout card
Date: Tue, 3 Oct 2006 15:58:21 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610031558.21609.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Recently I see some odd behaviour of my wifi card + Linux duet. The card is 
Enterasys Roamabout. The AP is dlink DWL-900AP+ though it seems to work fine 
with other clients. WEP is enabled. Orinoco driver is used.

eth0: Hardware identity 0001:0001:0004:0000
eth0: Firmware determined as Lucent/Agere 8.72

The thing is that once a couple of days for no obvious reason the card seems 
to lose the AP signal. The laptop with this card is lets say 5m away from AP 
with only one brick wall in between. Running wavemon shows link quality close 
to/or zero and syslog is flooded with these logs (see the timing - looks like 
the hardware is 'choking' - the disconnect and connect takes place in the 
same exact second):

Oct  2 14:24:29 orion kernel: eth0: New link status: AP Out of Range (0004)
Oct  2 14:24:29 orion kernel: eth0: New link status: AP In Range (0005)
Oct  2 14:24:31 orion kernel: eth0: New link status: AP Out of Range (0004)
Oct  2 14:24:31 orion kernel: eth0: New link status: AP In Range (0005)
Oct  2 14:24:34 orion kernel: eth0: New link status: AP Out of Range (0004)
Oct  2 14:24:34 orion kernel: eth0: New link status: AP In Range (0005)
Oct  2 14:24:36 orion kernel: eth0: New link status: AP Out of Range (0004)
Oct  2 14:24:36 orion kernel: eth0: New link status: AP In Range (0005)
Oct  2 14:24:38 orion kernel: eth0: New link status: AP Out of Range (0004)
Oct  2 14:24:38 orion kernel: eth0: New link status: AP In Range (0005)
Oct  2 14:24:41 orion kernel: eth0: New link status: AP Out of Range (0004)
Oct  2 14:24:41 orion kernel: eth0: New link status: AP In Range (0005)
Oct  2 14:24:43 orion kernel: eth0: New link status: AP Out of Range (0004)
Oct  2 14:24:43 orion kernel: eth0: New link status: AP In Range (0005)
Oct  2 14:24:45 orion kernel: eth0: New link status: AP Out of Range (0004)
Oct  2 14:24:45 orion kernel: eth0: New link status: AP In Range (0005)

When this happens also lots of these are seen:

eth0: MAC controller error (WTERR). Ignoring.

On the other hand during normal operation link quality is very good and none 
of the above messages are seen in logs. For now, simple and reliable fix is 
simply to reattach the card. It is annoying though.

The laptop is running gentoo with vanilla kernel 2.6.18. This problems seem to 
be related to the latest 2.6.1x kernel releases. Narrowing it down probably 
would take weeks :/

Any ideas?

Regards,

	Mariusz Kozlowski
