Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422880AbWJaIac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422880AbWJaIac (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422972AbWJaIac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:30:32 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:13484 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422880AbWJaIab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:30:31 -0500
Date: Tue, 31 Oct 2006 09:30:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: jplatte@naasa.net
cc: linux-kernel@vger.kernel.org
Subject: Re: IPSEC and bridged interfaces
In-Reply-To: <200610301729.49089.lists@naasa.net>
Message-ID: <Pine.LNX.4.61.0610310927270.23540@yvahk01.tjqt.qr>
References: <200610301729.49089.lists@naasa.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Unfortunately, the kernel does not encrypt incoming packages any more. tcpdump 
>reveals, that all received replies (I tested it with ping) are forwarded 
>unencrypted, because they are visible on my firewall instead of being 
>encrypted. Is this a known problem? Is bridging and IPSEC (maybe with 
>masquerading) currently not supported? Or should I forward this issue to 
>another mailing list? 

Sounds like those packets are bridged rather than routed (or so it 
sounds). See if that's the case. Check
http://www.imagestream.com/~josh/PacketFlow-new.png for details.

You could try `ebtables -t broute -j DROP` to force all packets to be 
routed.


	-`J'
-- 
