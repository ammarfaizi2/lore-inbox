Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbULKPXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbULKPXm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbULKPXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:23:42 -0500
Received: from [213.146.154.40] ([213.146.154.40]:28619 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261945AbULKPXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:23:40 -0500
Date: Sat, 11 Dec 2004 15:23:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [VFS-EXPORTS] Why generic_forget_inode() is not exported?
Message-ID: <20041211152339.GA11522@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org
References: <41BAF6A7.6070102@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BAF6A7.6070102@sw.ru>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 04:31:19PM +0300, Kirill Korotaev wrote:
> Hello,
> 
> I have a question about EXPORTS in VEFS:
> if sb->drop_inode method is set, than it's called in iput_final().
> But it's impossible to call neither generic_drop_inode(), nor 
> generic_forget_inode() inside this handler. Only generic_delete_inode() 
> is accessiable.
> 
> why generic_delete_inode() is exported and generic_forget_inode() is not?
> It looks like it should. At least, from VFS interface point of view.

Because a) there's no intree user and b) people haven't explained why
they need it.

