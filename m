Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTHYMwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTHYMwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:52:23 -0400
Received: from it-backbone-1.infraserv.com ([212.38.2.131]:12813 "EHLO
	it-backbone-1.infraserv.com") by vger.kernel.org with ESMTP
	id S261835AbTHYMwV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:52:21 -0400
Message-ID: <2B6CA561B67B72418738D8F3D7853DA3020137E6@20-exchange-1.infraserv.com>
From: "Schindewolf, Stefan, Infraserv-Hoechst/DE" 
	<Stefan.Schindewolf@Infraserv.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: LUN- Gaps on HP VA7410 not recognized by scsi scan
Date: Mon, 25 Aug 2003 14:52:13 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Our company is running a HP Virtual Array 7410 as a Storage System for our
HP-UX, Linux and W2K servers.
A few weeks ago we connected a Cisco MDS9216 SAN- Switch for testing
purposes to our testing SAN.
As server we choose SuSE Enterprise Server 8 with Kernel 2.4.19 Build 304
and a Windows box.

We configured the first two LUNs for Windows and the following two for
Linux.
Linux did not recognize his LUNs. Only after permitting Linux access to the
Windows LUNs it would "see" his own storage.

We contacted our HP Support and they found out, that in the following line
the product number is incorrect:
{"HP", "A6189B", "*", BLIST_SPARSELUN | BLIST_LARGELUN},	//HP Va7410
Array
It should be A6218A. Otherwise Linux would miss every LUN located "behind" a
LUN- Gap.
As this is not a SuSE specific problem, I am posting it to this mailing
list.
If you have further questions, please contact me.

Thanks and best regards.

> Stefan Schindewolf
> 
> Infraserv GmbH & Co Höchst KG
> Service Center Informationstechnologie
> D710, D-65926 Frankfurt
> Telefon: +49/69/305-43870
> Fax: +49/69/305-23549
> mailto:stefan.schindewolf@infraserv.com
> http://www.infraserv.com
> 
> 
