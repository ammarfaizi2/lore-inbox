Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265391AbSJaULp>; Thu, 31 Oct 2002 15:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265392AbSJaULp>; Thu, 31 Oct 2002 15:11:45 -0500
Received: from stine.vestdata.no ([195.204.68.10]:58808 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S265391AbSJaULn>; Thu, 31 Oct 2002 15:11:43 -0500
Date: Thu, 31 Oct 2002 21:17:47 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Christoph Hellwig <hch@infradead.org>, Nikita Danilov <Nikita@Namesys.COM>,
       Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
Message-ID: <20021031211747.V30076@vestdata.no>
References: <15809.21559.295852.205720@laputa.namesys.com> <20021031161826.A9747@infradead.org> <15809.22856.534975.384956@laputa.namesys.com> <20021031163104.A9845@infradead.org> <20021031173311.GA23959@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021031173311.GA23959@clusterfs.com>; from adilger@clusterfs.com on Thu, Oct 31, 2002 at 10:33:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 10:33:11AM -0700, Andreas Dilger wrote:
> On Oct 31, 2002  16:31 +0000, Christoph Hellwig wrote:
> > What about chaing truncate_inode_pages to take an additional len
> > argument so you don't have to remove all pages past an offset?
> 
> That would be what we have been calling "punch", and is quite useful
> for putting holes in files (i.e. making them sparse again).  This
> can be used for InterMezzo (among other things) so that the KML log
> file can be growing at the end, but being punched out at the start
> so it doesn't use up a lot of disk space.

It's also very useful for HSM-software (Hirarcial Storage Management).


-- 
Ragnar Kjørstad
Big Storage
