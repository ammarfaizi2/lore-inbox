Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312354AbSDEHqk>; Fri, 5 Apr 2002 02:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312357AbSDEHqb>; Fri, 5 Apr 2002 02:46:31 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:21004 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S312354AbSDEHqU>; Fri, 5 Apr 2002 02:46:20 -0500
Message-ID: <3CAD55F7.55C56F96@aitel.hist.no>
Date: Fri, 05 Apr 2002 09:44:55 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.7-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: joeja@mindspring.com
CC: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <Springmail.0994.1017972604.0.67144600@webmail.atl.earthlink.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joeja@mindspring.com wrote:
> 
> Think pre init scripts....
> 
> no apache was install on this machine, no iptables scripts, etc.
> 
> I'm actually talking about the time from where Linux spits out all this crap about probing irq's, ide drive found with dma etc.  That kind of stuff.

Compile your own kernel with drivers only for hardware you
actually have and use during boot.  Omit all other drivers.  That gets
rid
of a lot of probing, and the time from "kernel loaded" to "starting
init"
gets quite short.  Also, some drivers lets you specify irq's etc.
on the kernel command line - that may avoid further probing.

Drivers for things not needed in the kernel boot process (cdrom, floppy, 
ethernet, etc.) can be made modular.  That avoids time-consuming cd
spinup
and probing of non-boot devices.

The kernel boot is only a few seconds on my office machine.  The bios
boot is one long delay, the initscripts another.

Helge Hafting
