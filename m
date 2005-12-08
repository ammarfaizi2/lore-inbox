Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVLHMMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVLHMMy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 07:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVLHMMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 07:12:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24038 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750898AbVLHMMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 07:12:53 -0500
Subject: Re: Broadcom 43xx first results
From: Arjan van de Ven <arjan@infradead.org>
To: Jiri Benc <jbenc@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joseph Jezak <josejx@gentoo.org>,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>,
       Jouni Malinen <jkmaline@cc.hut.fi>
In-Reply-To: <20051208130751.6586c59d@griffin.suse.cz>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	 <20051205190038.04b7b7c1@griffin.suse.cz> <4394892D.2090100@gentoo.org>
	 <20051205195543.5a2e2a8d@griffin.suse.cz> <4394902C.8060100@pobox.com>
	 <20051208130751.6586c59d@griffin.suse.cz>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 13:12:44 +0100
Message-Id: <1134043965.2867.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 3. Most of WE calls can be handled by ieee80211 itself. The rest should
> be propagated to a driver in some easier way than requiring driver to
> deal with the whole WE stuff itself. Also, exporting callbacks from
> ieee80211 that driver has to set as particular WE handlers seems to be
> unnecessary complicated.

this argument is analogue to the adaptec SAS driver one about the scsi
host structure. ieee80211 should be a LIBRARY of functions that can do
things, the driver should be able to use the library or not at its own
choice. forcibly making the ieee80211 layer deal with the WE's is the
wrong way for this kind of thing, especially since several layers of the
stack will be optional, so it has to be possible for drivers to go
"until this layer I use the ieee80211 library functions, below that my
own".


