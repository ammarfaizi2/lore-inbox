Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSJaQME>; Thu, 31 Oct 2002 11:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbSJaQME>; Thu, 31 Oct 2002 11:12:04 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:4874 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262580AbSJaQMC>; Thu, 31 Oct 2002 11:12:02 -0500
Date: Thu, 31 Oct 2002 16:18:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
Message-ID: <20021031161826.A9747@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Linus Torvalds <Torvalds@Transmeta.COM>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
	Reiserfs mail-list <Reiserfs-List@Namesys.COM>
References: <15809.21559.295852.205720@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15809.21559.295852.205720@laputa.namesys.com>; from Nikita@Namesys.COM on Thu, Oct 31, 2002 at 07:03:03PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 07:03:03PM +0300, Nikita Danilov wrote:
> Hello, Linus,
> 
>     Following patch exports remove_from_page_cache(). reiser4 stores all
>     meta-data in the page cache. When piece of meta-data is removed,
>     corresponding page has to be removed from the page cache (this is
>     similar to truncate, but for meta-data), explicit call to
>     remove_from_page_cache() is required at this point.

Could you please explain the code that needs it?  No one should
call this in individual filesystem drivers.
