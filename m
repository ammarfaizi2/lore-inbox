Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264529AbTEJXpu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 19:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbTEJXpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 19:45:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:964 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264529AbTEJXpr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 19:45:47 -0400
Date: Sun, 11 May 2003 00:58:25 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: logs full of chatty IDE cdrom
Message-ID: <20030510235825.GG662@gallifrey>
References: <20030510201744.GD662@gallifrey> <1052599284.19351.2.camel@dhcp22.swansea.linux.org.uk> <20030510224734.GF662@gallifrey> <1052605114.19350.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052605114.19350.9.camel@dhcp22.swansea.linux.org.uk>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.69 (i686)
X-Uptime: 00:47:17 up 12:45,  1 user,  load average: 0.02, 0.06, 0.08
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:

> That is interesting. Someone sent a SCSI command the it really didn't
> like. This isn't a dell 8100 or similar laptop is it btw ?

Nope, thats just a standard DVD; its plugged into one channel of a
Promise Ultra100 TX2; an Iomega Zip 100 is a slave on the same channel.
Everything works fine - the only problem is the log messages from audio
playing. /proc/ide/hde/settings is:

name                    value           min             max
mode
----                    -----           ---             --- ----
current_speed           0               0               70 rw
dsc_overlap             1               0               1 rw
ide-scsi                0               0               1 rw
init_speed              0               0               70 rw
io_32bit                0               0               3 rw
keepsettings            0               0               1 rw
nice1                   1               0               1 rw
number                  0               0               3 rw
pio_mode                write-only      0               255 w
slow                    0               0               1 rw
unmaskirq               0               0               1 rw
using_dma               0               0               1 rw

My full set of IDE stuff is:

On board AMD 766 ViperPlus IDE:
   hda - IBM Deathstar 60GB
   hdc - Memorex CD-RW with ide-scsi

Promise Ultra100 TX2
   hde - the offending DVD ROM
   hdf - Iomega ZIP 100 ATAPI
   hdg - IBM Deathstar 60GB

> I guess people with raw drive access should learn to program as well. You
> could play with drive->quiet I guess (I think its drive->quiet) but right
> now the IDE layer has no notion of how severe an error is although it has
> some idea who caused it. For 2.5.x passing quiet/loud in the taskfile is
> a viable extension for 2.4 its not so clear how you would do it nicely.

I guess I was really after a /proc/ide/hd?/verbosity to shut the drive
up independent of what application was trying to talk to it.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
