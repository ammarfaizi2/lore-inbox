Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTKFTfw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbTKFTfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:35:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:3767 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263787AbTKFTft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:35:49 -0500
Date: Thu, 6 Nov 2003 11:35:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <boe68a$f3g$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0311061132010.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Nov 2003, bill davidsen wrote:
> 
> There is a problem with ide-scsi in 2.6, and rather than fix it someone
> came up with a patch to cdrecord to allow that application to work
> properly, and perhaps "better" in some way.

Wrong.

The "somebody" strongly felt that ide-scsi was not just ugly but _evil_, 
and that the syntax and usage of "cdrecord" was absolutely stupid.

That somebody was me.

ide-scsi has always been broken. You should not use it, and indeed there 
was never any good reason for it existing AT ALL. But because of a broken 
interface to cdrecord, cdrecord historically only wanted to touch SCSI 
devices. Ergo, a silly emulation layer that wasn't really worth it.

The fact that nobody has bothered to fix ide-scsi seems to be a result of 
nobody _wanting_ to really fix it. 

So don't use it. Or if you do use it, send the fixes over.

		Linus

