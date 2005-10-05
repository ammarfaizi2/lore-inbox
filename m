Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbVJEOoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbVJEOoo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVJEOoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:44:44 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:51846 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932635AbVJEOoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:44:44 -0400
Date: Wed, 5 Oct 2005 10:44:41 -0400
To: Marc Perkel <marc@perkel.com>
Cc: Nix <nix@esperi.org.uk>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005144441.GC8011@csclub.uwaterloo.ca>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343E611.1000901@perkel.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 07:41:21AM -0700, Marc Perkel wrote:
> If you were going to do it right here's what you would do:
> 
> People who had files in /tmp would have no rights at all to other users 
> /tmp files.
> Listing the dirtectory would only display the files you had some access 
> to. If you have no rights you don't even see that the file is there.
> The effect would be like giving people their own tmp directories.

Except it still wouldn't be able to go: Does file xyz exist?  If not,
create file xyz.  If someone else had xyz that you didn't see, you would
still not be able to create it.  So what is the point of NOT showing it
other than to make it much harder to avoid conflicting names?

if you want to not see files that you have no rights to, filter it in
your user space application when it matters, and let user space see the
files when they need to in order to avoid name conflicts.

It would be an incredibly idiotic system that auto hides files just
because you can't use them.  We have ways to hide files in user space
for the convinience of users.  It would be too inconvinient for
applications if the OS hid files on us.

Len Sorensen
