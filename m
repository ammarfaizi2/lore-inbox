Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271973AbRIDNmY>; Tue, 4 Sep 2001 09:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271974AbRIDNmO>; Tue, 4 Sep 2001 09:42:14 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:45839 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S271973AbRIDNmE>; Tue, 4 Sep 2001 09:42:04 -0400
Date: Tue, 4 Sep 2001 15:42:21 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Rastislav Stanik <rastos@woctni.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
Message-ID: <20010904154221.J19621@arthur.ubicom.tudelft.nl>
In-Reply-To: <XFMail.010904145710.rastos@woctni.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.010904145710.rastos@woctni.sk>; from rastos@woctni.sk on Tue, Sep 04, 2001 at 02:57:10PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 02:57:10PM +0200, Rastislav Stanik wrote:
> I'm developing specialized plotter.
> The moving parts of the plotter are controlled by ISA card that generates
> (and responds to) interrupts on each movement or printing event.
> The interrupts can be generated quite fast; up to frequency of 4kHz.

I just made a driver for a couple of serial A/Ds that runs at 2kHz on a
StrongARM platform. The system doesn't have any problems to keep up
with that frequency, so I think 4kHz would still be OK.

> I need to write a driver for that.
> The 1st prototype is developed in MS-DOS,but I hit problem with memory.
> The driver needs to use (and transfer) quite big chunks of memory.
> 1MB is not enough.
> 
> In NT you don't develop drivers so easily. It is actually a pain.
> Therefore I'm considering Linux. The machine would be probably 
> dedicated and, may be later, embeded in the plotter.
> Problems:
> - It is unlikely that my driver would ever make it to main-stream
>   kernel source.

That's no problem, most of the embedded drivers never do.

> - I'm just a C/C++ programmer, I have just rough idea what does it
> mean to 'develop a driver in Linux'. I'm pretty familiar with Linux
> as sys-admin though.

Forget about C++ for kernel programming, it simply doesn't work (see
the lkml FAQ at http://www.tux.org/lkml/ ). A nice starting point for
kernel programming is http://www.kernelnewbies.org/ together with its
IRC channel #kernelnewbies. Also get a copy of the book "Linux device
drivers (2nd edition)", there is a link in the books section on the
kernelnewbies website.

> All I need is: to have piece of code executed on some interrupt,
> read/write IO ports of the card and be able to transfer big pieces
> of memory to the card.
> 
> What do you think? Is Linux the ideal platform for me?

I don't know if Linux is the *ideal* platform, but driving a plotter
could certainly be done in Linux.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
