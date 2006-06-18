Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWFRPOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWFRPOM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWFRPOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:14:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51886 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751085AbWFRPOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:14:12 -0400
Date: Sun, 18 Jun 2006 16:14:11 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andr? Goddard Rosa <andre.goddard@gmail.com>
Cc: linux list <linux-kernel@vger.kernel.org>
Subject: Re: Support for SEEK_HOLE and SEEK_DATA for sparse files on lseek(2)
Message-ID: <20060618151411.GV27946@ftp.linux.org.uk>
References: <b8bf37780606180620y6e980e04k5b35da2c61fa1d1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8bf37780606180620y6e980e04k5b35da2c61fa1d1f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 09:20:43AM -0400, Andr? Goddard Rosa wrote:
> Hi, all!
> 
> Jeff Bonwick, from Slab allocator and ZFS fame is asking for comments on
> supporting SEEK_HOLE and SEEK_DATA for sparse files on lseek(2), like
> stated in this snip:
> 
> "Portability
> At this writing, SEEK_HOLE and SEEK_DATA are Solaris-specific. I
> encourage (implore? beg?) other operating systems to adopt these
> lseek(2) extensions verbatim (100% tax-free) so that sparse file
> navigation becomes a ubiquitous feature that every backup and
> archiving program can rely on. It's long overdue."

Well...  Description makes sense and it isn't hard to implement.
About the only question is about semantics for directories...
