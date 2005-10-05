Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbVJEP0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVJEP0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbVJEP0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:26:21 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:5785 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965216AbVJEP0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:26:20 -0400
Date: Wed, 5 Oct 2005 11:26:18 -0400
To: Marc Perkel <marc@perkel.com>
Cc: Nix <nix@esperi.org.uk>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005152618.GC7949@csclub.uwaterloo.ca>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <4343E7AC.6000607@perkel.com> <20051005145606.GA7949@csclub.uwaterloo.ca> <4343EC6A.70603@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343EC6A.70603@perkel.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 08:08:26AM -0700, Marc Perkel wrote:
> Agian - thinking outside the box.
> 
> If the permissions were don'e right in your own directories your 
> inherited rights would give your permissions automatically to your home 
> directory and all directories uner it. Netware has a concept called an 
> inherited rights mask - something Linux lacks. Windows also has rights 
> like this and Samba emulates it. So unless root put files in your 
> directory and specifically denied you rights to them, you would have 
> full rights to your own directory.

Well I could have setup my home dirs with ACL to have inherited rights
to all files created under it for the owner.  Well I didn't but then
again I don't allow other people to write to my home dir so it hasn't
been a problem.

> However - if you were browsing the /etc directory and there were files 
> there that you had no read or write access to - then you wouldn't even 
> be able to list them. If you went to the home directory and lets say 
> everyone had 700 permissions on all the directories withing home, you 
> would only see your own directory. You wouldn't even be able to know 
> what other directories existed there.

Well I don't have write access to /etc so who cares.  I do have write
access to /tmp and there is matters that I can list files I have no
access to.  Hence why /tmp IS readable by all.  If I couldn't list files
there I would have to randomly try filenames until I found one that
wasn't already in use but invisible to me due to idiot magic.

What error does netware return if you try to create a file in a
directory that already exists but which you can't see?  Any error would
be indirectly a way to see the file, so it should have just been visible
in the first place.

> If you want to start thinking about DOING IT RIGHT you need to think 
> beyond the Unix model and start looking at Netware. Maybe in 5 years 
> Linux will evolve to where Netware was in 1990.

NetWare was not the be all and end all of filesystems.  Far from it.  It
had some good points, but it certainly didn't solve everything.

> Unix permissions totally suck but it's old baggage that you're stuck 
> with somewhat. Are you going to be stuck forever and is Linux ever going 
> to grow up and move on to better things? Linux is crippled when it comes 
> to permissions. The Windows people are laughing at you and you don't 
> even get it why they are laughing.

I find unix permissions work great in general, and for complex things
posix ACL has done everything I wanted it to and works great with samba.

The behaviours you claim are so great in netware to me seem like things
I would very much NOT want to have to deal with.  I like things simple
enough to understand them so I can make sure they are right.

Len Sorensen
