Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293482AbSCGGiz>; Thu, 7 Mar 2002 01:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293503AbSCGGig>; Thu, 7 Mar 2002 01:38:36 -0500
Received: from mark.mielke.cc ([216.209.85.42]:26635 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S293490AbSCGGi2>;
	Thu, 7 Mar 2002 01:38:28 -0500
Date: Thu, 7 Mar 2002 01:34:15 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: "Busch, Jeff" <jbusch@ebay.com>
Cc: "'Chris Friesen'" <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: ClearCase and Linux.
Message-ID: <20020307013415.A27298@mark.mielke.cc>
In-Reply-To: <6B6D37BA3067914B85085671A1D3293A1E55CC@aus-exm-01.corp.ebay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <6B6D37BA3067914B85085671A1D3293A1E55CC@aus-exm-01.corp.ebay.com>; from jbusch@ebay.com on Thu, Mar 07, 2002 at 12:00:14AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 12:00:14AM -0600, Busch, Jeff wrote:
> > Just wanted to throw in my two cents.  I dislike clearcase.  
> > It's dog slow,
> > doesn't support atomic updates of multiple files, and is 
> > generally a pain in the
> > butt to use.
> Yep.  The kernel restrictions on ClearCase are hideous.  Right now, AFAIK,
> the newest supported kernel on RedHat 7.1 is RedHat's 2.4.9-6.  They ship
> binary-only precompiled modules and blow up if you try to use an unknown
> version.  If it doesn't blow up, you can only use it in a "restricted" mode
> which disables dynamic views.

The Linux kernel becomes mildly unstable with the MVFS kernel module
loaded and in use. (mildly unstable = I choose to reboot once a week,
instead of leaving the machine up for months on end - If I chose otherwise,
I would fear having the machine crash when I didn't want it to)

That said, I've had recent version of Linux-2.4 crash on their own. Finally,
2.4.17, and now 2.4.18 are much more stable.

> > Unfortunately, its the official versioning system at work and 
> > all new projects
> > are strongly encouraged to use it.
> Good luck.  It's a royal pain to set up a development environment that does
> not look like your production environment, especially when your dev servers
> crash and lose all of their views and any un-checked-in files.

It isn't any more of a pain than any other source management environment.

Also, your view servers should not be crashing on you. Fire your ClearCase
administrators! :-)

I don't mean to encourage the use of ClearCase too much, but some complaints
are warranted, and others are not. ClearCase is dog-slow. ClearCase is
bloated, and the kernel module does tend not to work on kernels other
than the kernels that Rational has chosen to test against. It works with
effort - there is a thin shim layer between the precompiled code and the
rest of the kernel that you can compile - it isn't easy, and it may not
work for version far away from their tested versions.

In linux-2.2, I had it (MVFS support in Linux) work around 3 patch
version more recent than the version it was published to work
with... it only stopped working when linux-2.2.12 or so decided to use
a few different names for functions that the precompiled module
assumed existed. The only benefit of Rational not precompiling the
module would have been that I would have been able to edit their
source to adjust it to work myself. It would have required alteration
regardless.

The real complaints against ClearCase are execution speed, and an
inability to perform several checkin operations as an atomic
operation. In the latter case, UCM, which comes with ClearCase, solves
the issue in a different way. They provide an atomic labelling
mechanism that allows one to label all element versions that belong to
a submitted change set. (Too bad they messed up the rest of UCM to
make it not usable by all existing customers with any existing
metadata that they wish to continue to use)

The complaint about Linux is only a partial complaint, as ClearCase
was written for Solaris, and HP-UX, and more recently, for WinNT. They
have since added support for Linux due to demand. The fact that things
don't work perfectly yet is not a reason to shut them down for trying.
If every company that tried porting their software to work on Linux was
shot down, nobody would bother to put in the effort. I view it as a
*positive* change that companies are seriously considering Linux.

I have not seen MVFS-like support in any other source management tool,
so holding it against ClearCase that MVFS is not perfect under Linux
is not valid - ClearCase snapshot views work better than CVS.

I still intend to look at BitKeeper and see what it provides.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

