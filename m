Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292747AbSBUUD0>; Thu, 21 Feb 2002 15:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292745AbSBUUDQ>; Thu, 21 Feb 2002 15:03:16 -0500
Received: from [212.159.14.227] ([212.159.14.227]:61070 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S292746AbSBUUDB>; Thu, 21 Feb 2002 15:03:01 -0500
Date: Thu, 21 Feb 2002 20:04:59 +0000
From: "J.P. Morris" <jpm@it-he.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rc2 problem..
Message-Id: <20020221200459.642e3bb3.jpm@it-he.org>
In-Reply-To: <20020220190509.GA30784@kroah.com>
In-Reply-To: <20020220185855.2bcecc24.jpm@it-he.org>
	<20020220190509.GA30784@kroah.com>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002 11:05:09 -0800
Greg KH <greg@kroah.com> wrote:

> On Wed, Feb 20, 2002 at 06:58:55PM +0000, J.P. Morris wrote:
> > 
> > I'm getting a problem in usb-storage (it's loaded as a module towards the end
> > of the boot sequence).  The module locks during initialisation, which doesn't
> > happen in 2.4.17.
> 
> Does the lockup happen without the CF reader plugged in?

No.

> If so, and you later plugin the CF reader (after the module is loaded)
> does the kernel still lock up?

No.  However, the reader then doesn't work either.
No device entries get created for it (I'm using devfs).
It's a multiformat reader (CF/SM/MMC) so there will be a cluster of
entries when it is working correctly.

Note that the kernel itself doesn't lock, just the module.
That is, the module never completes initialisation and sits there forever.
When it was being loaded by script at boot, I had to use Alt-Sys-K to kill
the process trying to load the module in order to log in.

I have tried upgrading just the usb-storage module from 2.4.17 to 2.4.18
and (unfortunately) it still works.. the cause of the problem is elsewhere.

Any ideas?  Thanks.

> thanks,
> 
> greg k-h
> 


-- 
JP Morris - aka DOUG the Eagle (Dragon) -=UDIC=-  doug@it-he.org
Fun things to do with the Ultima games            http://www.it-he.com
Developing a U6/U7 clone                          http://ire.it-he.org
d+++ e+ N+ T++ Om U1234!56!7'!S'!8!9!KA u++ uC+++ uF+++ uG---- uLB----
uA--- nC+ nR---- nH+++ nP++ nI nPT nS nT wM- wC- y a(YEAR - 1976)
