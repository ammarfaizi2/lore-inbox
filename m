Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423550AbWJaQTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423550AbWJaQTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423547AbWJaQTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:19:25 -0500
Received: from rosi.naasa.net ([212.8.0.13]:39130 "EHLO rosi.naasa.net")
	by vger.kernel.org with ESMTP id S1423549AbWJaQTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:19:24 -0500
From: Joerg Platte <lists@naasa.net>
Reply-To: jplatte@naasa.net
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: IPSEC and bridged interfaces
Date: Tue, 31 Oct 2006 17:19:20 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200610301729.49089.lists@naasa.net> <Pine.LNX.4.61.0610310927270.23540@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610310927270.23540@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200610311719.20636.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 31. Oktober 2006 09:30 schrieb Jan Engelhardt:
Hi,

> Sounds like those packets are bridged rather than routed (or so it
> sounds). See if that's the case. Check
> http://www.imagestream.com/~josh/PacketFlow-new.png for details.

It looks like my router is able to re-map its IP to the corresponding private 
IP but then this packet is bridged instead of routed (or encrypted). 
Unfortunately, IPSEC routing is not listet in this image.

> You could try `ebtables -t broute -j DROP` to force all packets to be
> routed.

I tried 
ebtables -t broute -A BROUTING -p ipv4 --ip-destination 192.168.0.0/16 -j DROP
but this does not change anything (192.168.0.0/16 is my private, masqueraded 
network).  But nothing changed. I'm thinking about replacing my IPSEC VPN 
with an openvpn tunnel. Maybe then I'll have less problems.

regards,
Jörg

-- 
PGP Key: send mail with subject 'SEND PGP-KEY' PGP Key-ID: FD 4E 21 1D
PGP Fingerprint: 388A872AFC5649D3 BCEC65778BE0C605
