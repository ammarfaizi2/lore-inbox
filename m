Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTFTUhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264612AbTFTUhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:37:25 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:1243 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264619AbTFTUhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:37:24 -0400
Date: Fri, 20 Jun 2003 22:51:00 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Nicholas Wourms <nwourms@myrealbox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       jmorris@intercode.com.au, davem@redhat.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Breaking data compatibility with userspace bz2lib
Message-ID: <20030620205100.GE22732@wohnheim.fh-wedel.de>
References: <20030620185915.GD28711@wohnheim.fh-wedel.de> <20030620190957.GA19988@gtf.org> <3EF36E2C.3050906@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EF36E2C.3050906@myrealbox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 June 2003 16:27:24 -0400, Nicholas Wourms wrote:
> Jeff Garzik wrote:
> >On Fri, Jun 20, 2003 at 08:59:15PM +0200, J?rn Engel wrote:
> >The big question is whether the bzip2 better compression is actually
> >useful in a kernel context?  Patches to do bzip2 for initrd, for
> >example, have been around for ages:
> >
> >	http://gtf.org/garzik/kernel/files/initrd-bzip2-2.2.13-2.patch.gz
> >
> 
> Not to mention the more current ongoing work by Christian Ludwig for 
> 2.4.2x support at:
> 
> http://shepard.kicks-ass.net/~cc/

Hmm, both of them are already behind my work, and I just started this
week. :)

Ok, this isn't fair as I mainly concentrated on the bzlib itself,
jffs2 is likely the easiest user of compression in the kernel.  No
personal offense please.

Jeff didn't copy lib/inflate.c, a horrible hack that has to go, so his
patch is much better from that perspective.  But he kept the bzlib
pretty much verbatim, incl. _WIN32, functions working with FILE* and
so on.  Once you cut all that out, you start to see the real beauty of
the bzlib, it is much nicer than the older zlib.

Still, the blockSize100k part is just plain stupid and should die. 

Oh yes, thanks for the link.  Didn't know that patch.

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
