Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWKENKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWKENKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 08:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWKENKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 08:10:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57268 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932688AbWKENKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 08:10:14 -0500
Subject: Re: [PATCH 1/2] Add Legacy IDE mode support for SB600 SATA
From: Arjan van de Ven <arjan@infradead.org>
To: conke.hu@amd.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Luugi Marsan <luugi.marsan@amd.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162729080.8525.49.camel@localhost.localdomain>
References: <20061103185420.B3FA6CBD48@localhost.localdomain>
	 <1162582216.12810.40.camel@localhost.localdomain>
	 <1162729080.8525.49.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 05 Nov 2006 14:10:10 +0100
Message-Id: <1162732210.3160.86.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 20:17 +0800, Conke Hu wrote:
>     b). We have a RAID driver (close source) for SB600 SATA which does
> not depends on the open source AHCI driver in linux kernel and supports
> both AHCI and RAID. But if the controller is configured as legacy IDE by
> BIOS, the RAID driver cannot run at all because of the IRQ policy. 

that is your own problem and in fact a very good reason to reject your
change. In linux, device mapper deals with such "raid", and your change
will block that.
Reverse engineering such raid is usually a one day effort, and it will
be done.. and that is a good thing. Trying to make that impossible is
just even dishonest [1].


[1] See Greg Kroah's OLS keynote. It's one thing to think your "raid IP"
is worth more than the Linux kernels IP, it's another one to sabotage
the Linux kernel to protect your "raid IP".
 

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

