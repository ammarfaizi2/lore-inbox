Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289455AbSAJONO>; Thu, 10 Jan 2002 09:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289459AbSAJONF>; Thu, 10 Jan 2002 09:13:05 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:17549
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S289455AbSAJOMw>; Thu, 10 Jan 2002 09:12:52 -0500
Date: Thu, 10 Jan 2002 09:22:10 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: David Balazic <david.balazic@uni-mb.si>
Cc: matthias.andree@stud.uni-dortmund.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Simple local DOS
Message-ID: <20020110092209.A1357@animx.eu.org>
In-Reply-To: <3C3D9B2B.2DDB72CB@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3C3D9B2B.2DDB72CB@uni-mb.si>; from David Balazic on Thu, Jan 10, 2002 at 02:46:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > log in on some virtual terminal, then run the following line 
> > > in a bourne type shell, like bash : 
> > > 
> > > X 2>&1 | less 
> 
> > or by just not piping X 

into less or more.

> I didn't do it on purpose to lock up my system and risk FS corruption
> durin unclean reboot. I was interested in the server output and " 2>&1 | less"
> is the logical way to do that.
> 
> I could also "solve" this problem by not running linux. And I can "solve" all
> gcc bugs by not using gcc. Those are not solutions. Not to me at least.

You could also solve all your computer problems by not using a computer.

> > output into interactive programs. tail -f is a viable workaround -- and 
> 
> tail -f ? what is the difference between :
> $ X 2>&1 | tail -f
> and
> $ X 
> ?
> 
> > all this is off-topic on linux-kernel,
> 
> non-root user locked up the console code. console code is part of kernel.
> it is a kernel topic.

This is not the problem. It's not the kernel's fault, it's less's fault. 
When you pipe to less, it only reads enough to display on the screen.  X is
sending tons more information than less is willing to read therefor X will
block (stop) until less reads more.  I've done this myself.  my work around
is to press END as soon as I hit enter.  That way less will go to the end
and not block.

You're better off doing:
X > somefile 2>&1
then lessing "somefile".  this won't block the X server.

I agree with matt that this is off-topic as it's not a kernel issue, it's
userland.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
