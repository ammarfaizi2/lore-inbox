Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270306AbTGMRIT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 13:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270307AbTGMRIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 13:08:19 -0400
Received: from deepthot.org ([216.19.203.209]:3721 "EHLO dent.deepthot.org")
	by vger.kernel.org with ESMTP id S270306AbTGMRIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 13:08:16 -0400
Date: Sun, 13 Jul 2003 10:23:20 -0700 (MST)
From: Jay Denebeim <denebeim@deepthot.org>
To: linux-kernel@vger.kernel.org
Subject: Solution: Re: Could not open debufiles.list on Redhat 9 kernel
 compile
Message-ID: <Pine.LNX.4.44.0307131022430.27393-100000@hotblack.deepthot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jul 2003, Martin List-Petersen wrote:

> Yep .. all -b switches have been moved from rpm to rpmbuild.

I'm aware of that.  There's a better way BTW that's documented in the RPM 
man page.  There's a file called /etc/popt that you can put a bunch of 
macros in to cause rpm to call rpmbuild.  This is a much cleaner 
implementation since it works for all of the packages that use RPM rather 
than just the kernel.

> So if you edit the Makefile, replacing call of "rpm" with "rpmbuild" it
> works.

Unfortunately, this has nothing to do with my problem.  That was something 
that happened in redhat 8 not 9.  The redhat 9 feature creates a debug 
package for every package you create, at least it tries to.  This 
aparently doesn't work for the kernel.  I don't know exactly what the 
mechinisim is.

Anyway, I got a helpful e-mail from a redhat person.  I'm still compliling 
the kernel now, but what he told me is you need to change 

%_enable_debug_packages 1

to 

%_enable_debug_packages %{nil}

not 0.  In /usr/lib/rpm/redhat/macros

If you have this problem try it and see if it works.

Thanks to everyone for all the help
Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *


