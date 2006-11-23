Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933078AbWKWIGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933078AbWKWIGN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933118AbWKWIGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:06:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52176 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933078AbWKWIGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:06:13 -0500
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
From: Arjan van de Ven <arjan@infradead.org>
To: Conke Hu <conke.hu@amd.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com>
References: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 23 Nov 2006 09:05:59 +0100
Message-Id: <1164269159.31358.769.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 12:20 +0800, Conke Hu wrote:
> ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID. Legacy/Native IDE mode is designed for compatibility with some old OS without AHCI driver but looses SATAII/AHCI features such as NCQ. This patch will make SB600 SATA run in AHCI mode even if it was set as IDE mode by system BIOS.


is this really the right thing? You're overriding a user chosen
configuration here.... while that might be justifiable.. it's probably a
good idea to at least provide a safety-valve for this one. The user
might have made that selection very deliberately.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

