Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbSJRQIJ>; Fri, 18 Oct 2002 12:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265200AbSJRQIJ>; Fri, 18 Oct 2002 12:08:09 -0400
Received: from users.linvision.com ([62.58.92.114]:62346 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S265197AbSJRQIH>; Fri, 18 Oct 2002 12:08:07 -0400
Date: Fri, 18 Oct 2002 18:13:56 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Gruenbacher <agruen@suse.de>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities
Message-ID: <20021018181356.A1664@bitwizard.nl>
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at> <20021017032619.GA11954@think.thunk.org> <874rblcpw5.fsf@goat.bogus.local> <200210171302.25413.agruen@suse.de> <20021017121213.GA13573@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017121213.GA13573@think.thunk.org>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 08:12:13AM -0400, Theodore Ts'o wrote:
> On Thu, Oct 17, 2002 at 01:02:25PM +0200, Andreas Gruenbacher wrote:
> > Filesystem capabilities move complexity out of applications into the
> > file system (=system configuration), so the admins have to deal with
> > an additional task.
> > 
> > From a security point of view suid root applications that are
> > dropping capabilities voluntarily aren't much different from plain
> > old suid root apps; there may still be exploitable bugs before the
> > code that drops capabilities (which doesn't mean that apps shouldn't
> > drop capabilities). With capabilities the kernel ensures that
> > applications cannot exceed their capabilities.
> 
> If developers drop capabilities they don't need as the very first
> thing that the program does --- i.e., the first statement in main()
> --- then it's done once, and it's no longer a configuration issue.

I'm a C-programmer. I've looked at C++ a long time ago. 

Turns out that my system also supports C++. I still don't care. 

Turns out that C++ specifies that some code should be run before main
starts. 

It seems that if I happen to link with a library that uses C++
internally, some code in that library can get run before my first
statement in main.  Suddenly it IS my problem. 

NOT GOOD. 

If capabilities are correctly implemented, having "all" capabilities
will mean that it's equivalent to "setuid-root". Nothing worse than
what we have now. I can currently decide to take the setuid-ness of
mount away. I can currently decide to install a setuid bit on "lilo".
That is the flexibility of having it in the filesystem.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenyly in such an      * 
* excursion: The stable situation does not include humans. ***************
