Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267604AbUHMVqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267604AbUHMVqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 17:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUHMVqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 17:46:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62688 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267604AbUHMVqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 17:46:31 -0400
Date: Fri, 13 Aug 2004 17:22:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Olaf Hering <olh@suse.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: module.viomap support for ppc64
Message-ID: <20040813202218.GD29875@logos.cnet>
References: <20040812173751.GA30564@suse.de> <1092339278.19137.8.camel@localhost> <1092354195.25196.11.camel@bach> <20040813094040.GA1769@suse.de> <1092404570.29604.5.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092404570.29604.5.camel@bach>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 11:42:50PM +1000, Rusty Russell wrote:
> On Fri, 2004-08-13 at 19:40, Olaf Hering wrote:
> >  On Fri, Aug 13, Rusty Russell wrote:
> > 
> > > 2) Please modify scripts/mod/file2alias.c in the kernel source, not the
> > > module tools.  The modules.XXXmap files are deprecated: device tables
> > > are supposed to be converted to aliases in the build process, and that
> > > is how userspace tools like hotplug are to find them.
> > 
> > I found no user of the modules.alias file. Hotplug still uses the map
> > files. Parsing one big file will not improve performance, but thats a
> > different story.
> 
> You don't use the modules.alias file.  You simply "modprobe vio:xyz^abc"
> and modprobe reads modules.alias if necessary (the user can also insert
> aliases in the modprobe.conf file, for example).  Note that fnmatch is
> used, so you can actually use ? and * in your generated aliases.
> 
> > A hack for 2.6.8-rc4 is below. Can I read the alias file via 
> > while read a b c ; do : done < modules.alias ?
> > Is b supposed to contain not spaces? What special delimiter chars are
> > allowed? The 'name' and 'compat' property can contain almost any char.
> > I used '^' for the time being.
> 
> Spaces are probably a bad idea, yes.  ^ is a little odd, but probably
> not a bad choice.  You could even use a full: "vio:name:%s:compat:%s" if
> you wanted to.
> 
> > > 3) I will still accept patches to module-init-tools if required for 2.4
> > > compatibility, but they will be going away at some point!
> > 
> > Noone cares about that old junk.

I do care! 

> Shh... Marcelo might get offended 8)

Yes, I, I, rrrr :)
