Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTJ0SmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTJ0SmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:42:22 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:38673 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263484AbTJ0SmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:42:20 -0500
Date: Mon, 27 Oct 2003 19:42:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@fs.tum.de>,
       James Morris <jmorris@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9: selinux compile error with "make O=..."
Message-ID: <20031027184217.GA1718@mars.ravnborg.org>
Mail-Followup-To: Stephen Smalley <sds@epoch.ncsc.mil>,
	Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@fs.tum.de>,
	James Morris <jmorris@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org> <20031026002209.GD23291@fs.tum.de> <20031026094923.GA925@mars.ravnborg.org> <1067262042.18818.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067262042.18818.11.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 08:40:42AM -0500, Stephen Smalley wrote:
> On Sun, 2003-10-26 at 04:49, Sam Ravnborg wrote:
> > Hi Adrian.
> > Known problem that has been reported back to the maintainers about
> > one month ago. But they do not seem to care enough to fix it.
> 
> I have no prior email regarding the issue. Who reported it, and to whom?
> Was it cc'd to any mailing list (e.g. lkml, lsm, or selinux)?
You and jmorris@redhat.com got an mail about it the 26th of September.
Probarly lost in usual mail noise.

> > The use of "-include" is a bad way to include files. The reader will
> > not see that global.h is included at all and will wonder how that
> > information get pulled in.
> 
> True, and the original reason for it is no longer valid, so we can
> change this.
Good.

> > Furhtermore the location of the header files under security/include
> > is considered bad practice. All headerfiles used from more than one
> > directory belongs to include/xxx, in this case include/security.
> > Then they can be included using
> > #include <security/secuity.h>
> 
> This was discussed when SELinux was originally submitted for merging,
> but these header files are private to the SELinux kernel module are
> never included into out-of-tree code, so it seemed unjustified to move
> them.  Now, if this breaks the build process, we can move them, but I
> would appreciate clarification as to whether this is truly a limitation
> of the build process for make O=.
The build system will handle the use of -I correct - I was only
referring to what is my understanding of the un-written rules for
location of .h files.
If the usage of -include is fixed then from a kbuild perspective there
is no problems.

	Sam
