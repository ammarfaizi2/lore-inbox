Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbTKNC1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 21:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTKNC1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 21:27:38 -0500
Received: from razorbill.mail.pas.earthlink.net ([207.217.121.248]:64927 "EHLO
	razorbill.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264497AbTKNC1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 21:27:37 -0500
From: Guy <fsos_guy@earthlink.net>
Organization: C
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6 scheduler and "fast user switching"
Date: Thu, 13 Nov 2003 19:58:36 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200311130430.06882.fsos_guy@earthlink.net> <3FB366DB.80508@cyberone.com.au> <200311131611.51951.fsos_guy@earthlink.net>
In-Reply-To: <200311131611.51951.fsos_guy@earthlink.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311131958.40404.fsos_guy@earthlink.net>
X-ELNK-Trace: d501ffacebf681585e89bb4777695beb702e37df12b9c9ef27617fd7ccf92de439d518124c83bcb0350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 November 2003 16:11, Guy wrote:
> On Thursday 13 November 2003 06:11, Nick Piggin wrote:
> > Guy wrote:
> > >A} My default security is that only 'root' can perform nice
> > > with negative values. I am reluctant to play with security
> > > for such a crticial command.
> >
> > Debian does this for you. I guess X runs as suid root anyway
> > so its not a big security problem.
>
> See comment above. PBSAK

>From http://members.optusnet.com.au/ckolivas/kernel

Renicing X? Many distributions (eg Mandrake) start X by default at 
a nice of -10 to make it more responsive. This is a workaround 
for the old scheduler limitations and the new scheduler makes 
this unecessary, and may actually promote audio skipping with 
this kernel. Each distribution may do this at different places 
but commonly in the file /usr/lib/X11/xdm/Xservers there will be 
a line that looks like this: 

:0 local /bin/nice -n -10 /usr/X11R6/bin/X -deferglyphs 16

 change it to: 

:0 local /usr/X11R6/bin/X -deferglyphs 16

 Gustavo Franco gave me this on how to do it on Debian: 

# dpkg-reconfigure xserver-common

Manage X server wrapper configuration file with debconf? yes
Select what type of user has permission to start the X server. 2
Enter the desired nice value for the X server to use. 0
To check "cat /etc/X11/Xwrapper.config".
 
-- 
Recyle computers. Install Gentoo GNU/Linux.

