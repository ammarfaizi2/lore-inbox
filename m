Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbTJ0No3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 08:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTJ0No3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 08:44:29 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:52872 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262602AbTJ0No1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 08:44:27 -0500
Subject: Re: 2.6.0-test9: selinux compile error with "make O=..."
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, James Morris <jmorris@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031026094923.GA925@mars.ravnborg.org>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
	 <20031026002209.GD23291@fs.tum.de> <20031026094923.GA925@mars.ravnborg.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1067262042.18818.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Oct 2003 08:40:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-10-26 at 04:49, Sam Ravnborg wrote:
> Hi Adrian.
> Known problem that has been reported back to the maintainers about
> one month ago. But they do not seem to care enough to fix it.

I have no prior email regarding the issue. Who reported it, and to whom?
Was it cc'd to any mailing list (e.g. lkml, lsm, or selinux)?

> The use of "-include" is a bad way to include files. The reader will
> not see that global.h is included at all and will wonder how that
> information get pulled in.

True, and the original reason for it is no longer valid, so we can
change this.

> Furhtermore the location of the header files under security/include
> is considered bad practice. All headerfiles used from more than one
> directory belongs to include/xxx, in this case include/security.
> Then they can be included using
> #include <security/secuity.h>

This was discussed when SELinux was originally submitted for merging,
but these header files are private to the SELinux kernel module are
never included into out-of-tree code, so it seemed unjustified to move
them.  Now, if this breaks the build process, we can move them, but I
would appreciate clarification as to whether this is truly a limitation
of the build process for make O=.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

