Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTIHI45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 04:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTIHI44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 04:56:56 -0400
Received: from users.linvision.com ([62.58.92.114]:33974 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S262086AbTIHI4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 04:56:55 -0400
Date: Mon, 8 Sep 2003 10:56:41 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Oleg Drokin <green@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030908105639.B26722@bitwizard.nl>
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net> <3F50D986.6080707@namesys.com> <20030831191419.A23940@bitwizard.nl> <20030908081206.GA17718@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908081206.GA17718@namesys.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 12:12:06PM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Sun, Aug 31, 2003 at 07:14:19PM +0200, Rogier Wolff wrote:
> 
> > Would it be possible to do something like: "pretend that there
> > are always 100 million inodes free", and then report sensible
> > numbers to "df -i"? 
> 
> This won't work. No sensible numbers would be there.
> 
> > There  is no installation program that will fail with: "Sorry, 
> > you only have 100 million inodes free, this program will need
> > 132 million after installation", and it allows me a quick way 
> > of counting the number of actual files on the disk.... 
> 
> You cannot. statfs(2) only exports "Total number of inodes on disk" and
> "number of free inodes on disk" values for fs. df substracts one from another one
> to get "number of inodes in use".

So, you report "oids_in_use + 100M" as total and "100M" as free inodes 
on disk. Voila!

We're using a Unix operating system which has a bunch of standard 
interfaces. The fun about using those is that lots of stuff "just works"
even if it wasn't designed to do exactly what you are doing right
now. So even if "df" wasn't designed to work on NFS, it still works.

But now we're going to get a new "df" which grabs the sysfs info and
uses that. But it won't work on reiserfs5, as the interface changes
again. 

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
