Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbVJEO4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbVJEO4K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVJEO4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:56:10 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:54663 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965192AbVJEO4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:56:08 -0400
Date: Wed, 5 Oct 2005 10:56:06 -0400
To: Marc Perkel <marc@perkel.com>
Cc: Nix <nix@esperi.org.uk>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005145606.GA7949@csclub.uwaterloo.ca>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <4343E7AC.6000607@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343E7AC.6000607@perkel.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 07:48:12AM -0700, Marc Perkel wrote:
> What is incredibly idiotic is a file system that allws you to delete 
> files that you have no write access to. That is stupid beyond belief and 
> only the Unix community doesn't get it.

If I have a directory and I want to remove it, I can almost always do
that.  The file only goes away if there are no other hardlinks to it.
If someone cares about the file, they should keep a hardlink to it in a
directory THEY own.

Directories within directories on the other hand can make things a pain
since if you don't own the subdir, you can't remove its contents, so you
can't remove it.  You could however likely move the dir somewhere else
to get it out of your way.

My directory is MY file and I get to do whatever I want to it.  Who
knows how someone else managed to get a file into it in the first place.

/tmp is of course different since it has the bit turned on that says
only the file owner can delete it.  If you want that enabled on all
directories, go ahead.  It is supported, although who knows what
applications that might break.  unix supports both ways of directory
behaviour after all.  It isn't one way or the other.

Len Sorensen
