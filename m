Return-Path: <linux-kernel-owner+w=401wt.eu-S965039AbXASKhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbXASKhe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 05:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbXASKhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 05:37:34 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:38600 "HELO
	embla.aitel.hist.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965039AbXASKhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 05:37:33 -0500
Message-ID: <45B09EE0.8070404@aitel.hist.no>
Date: Fri, 19 Jan 2007 11:35:12 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Erik Mouw <erik@harddisk-recovery.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, congwen <congwen@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How can I create or read/write a file in linux device driver?
References: <200701121547221465420@gmail.com> <9a8748490701120227h757d473ctaf5673aa318fe090@mail.gmail.com> <20070112132459.GY13675@harddisk-recovery.com> <Pine.LNX.4.61.0701120907430.23919@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0701120907430.23919@chaos.analogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Sometimes a idiot boss will say; "You need to read or write files from
> within the driver. If you don't do what I tell you, you are fired!"
>   
To which the response is something like
"This is impossible/illegal/unsupported so it can't be done." 
Fortunately, civilized countries have laws against being
fired for being unable to do the impossible.

Well, nothing is really impossible.  Tell the boss about
the man-hours needed to implement a kernel file API
from scratch, and then forking the kernel
in order to maintain this community-rejected abomination
forever.
> Sigh, assuming you can't walk next door and get a reasonable job, it
> __is__ possible to unreliably access files within the kernel. Note
> that the kernel is __designed__ to perform user-mode operations, so
> it is a bit difficult.
Another way is to cheat.  The boss asks the impossible, so
make a workaround in the form of a userspace program that
does the file writing while communicationg with the driver.
The driver installer software can then be made to install
this userspace program as well. Looks like a hack - but it
is the recommended way of doing these things. Often enough you
have a startup script for the thing anyway, a good place to
launch userspace helper apps.  Either that, or userspace
will be involved somehow in using the device - launch the
helper at that time.

Try not to get in a situation where the boss explicitly asks
for files written from the kernel.  If you're making a driver and
the boss ask for a file - just write that userspace helper
because that is the way it is done on linux.  No conflict there.

Helge Hafting






