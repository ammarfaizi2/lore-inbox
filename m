Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbUAFBl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUAFBlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:41:25 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:29451 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263891AbUAFBlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:41:23 -0500
Date: Tue, 6 Jan 2004 02:41:15 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Daniel Jacobowitz <dan@debian.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040106024115.B1153@pclin040.win.tue.nl>
References: <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <20040106001326.A1128@pclin040.win.tue.nl> <20040106000014.GL30464@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040106000014.GL30464@kroah.com>; from greg@kroah.com on Mon, Jan 05, 2004 at 04:00:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 04:00:15PM -0800, Greg KH wrote:

> > > Have you even _tried_ udev?
> > 
> > Yes, and it works reasonably well. I have version 012 here.
> > Some flaws will be fixed in 013 or so.
> 
> What flaws would that be?  The short time delay for partitions?  Or
> something else?

Yes, partitions are not handled very well.
So far I have never seen udev discover partitions on its own.
I provoke it using "blockdev --rereadpt".
The result is that partitions appear in /proc/partitions and in /udev.
After removing the media another "blockdev --rereadpt" returns
"No such device or address" and the entry in /proc/partitions
disappears, but that in /udev stays.

> > Some difficulties are of a more fundamental type, not so easy to fix.
> 
> Such as?

Udev cannot do anything when there are no events.
And media insertion or removal does not always give events.

Andries

[By the way, a compilation warning for every C file:
% make
gcc  -pipe -Wall -Wmore.. -Os -fomit-frame-pointer -D_GNU_SOURCE \
  -I/usr/lib/gcc-lib/i486-suse-linux/3.2/include -I.../udev-012/libsysfs
  -c -o udev.o udev.c
cc1: warning: changing search order for system directory
     "/usr/lib/gcc-lib/i486-suse-linux/3.2/include"
cc1: warning: as it has already been specified as a non-system directory]



