Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265257AbUGCVEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbUGCVEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 17:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUGCVEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 17:04:09 -0400
Received: from [213.146.154.40] ([213.146.154.40]:2506 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265257AbUGCVEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 17:04:08 -0400
Date: Sat, 3 Jul 2004 22:04:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, olaf+list.linux-kernel@olafdietsche.de
Subject: Re: procfs permissions on 2.6.x
Message-ID: <20040703210407.GA11773@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	olaf+list.linux-kernel@olafdietsche.de
References: <20040703202242.GA31656@MAIL.13thfloor.at> <20040703202541.GA11398@infradead.org> <20040703133556.44b70d60.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703133556.44b70d60.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Actually the patch you reference above looks extremly bogus and should just
> > be reverted instead.
> 
> Why is it "extremely bogus"?  I assume Olaf had a reason for wanting chmod
> on procfs files?

Because it turns the question what permissions a procfs file has into
a lottery game.  He only changes the incore inode owner and as soon as
the inode is reclaimed the old ones return.
