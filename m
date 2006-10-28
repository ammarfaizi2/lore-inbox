Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWJ1SlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWJ1SlE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWJ1SlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:41:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39180 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751349AbWJ1SlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:41:02 -0400
Date: Sat, 28 Oct 2006 18:40:48 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com
Subject: Re: How to document dimension units for virtual files?
Message-ID: <20061028184048.GB5152@ucw.cz>
References: <200610232103.33710.ioe-lkml@rameria.de> <OFA94CF0D3.C5318A12-ON42257211.004B4AC4-42257211.004E4728@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA94CF0D3.C5318A12-ON42257211.004B4AC4-42257211.004E4728@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 2. Encode dimension unit into filename (e.g. onlinetime_ms or
> memory_kb)
> >
> > This is the recommended one.
> > - simple to implement and understand on both sides
> >
> > - if you change units, you notice breaking userspace immediately
> >   and can even notice it being used in closed source tools
> >   with a simple strace
> >
> > - no parsing involved, as the author of the user space tool
> >   usually assumes the unit implicitly (like "programming by contract",
> where
> >   the "contract" is the filename, which is quite easy to check for.
> >
> > - you can keep a legacy interface with neglible effort and code wastage
> >
> > - many advantages I forgot :-)
> >
> 
> I also think that this is the best solution. It would be nice to have
> that documented somewhere. Maybe in the Documentation directory
> something like:
> 
> Howto export data in virtual files
> ==================================
> 
> If you want to export data to userspace via virtual filesystems
> like procfs, sysfs, debugfs etc., the following rules are recommended:

...yes please... such patch would be nice.

> - Export only one value in one virtual file.
> - Data format should be as simple as possible.
> - Use ASCII formated strings, no binary data if possible.
> - If data has dimension units, encode that in the filename.
>   Please use the following suffixes:
>   * kb: Kilobytes
>   * mb: Megabytes

just use B for bytes....

-- 
Thanks for all the (sleeping) penguins.
