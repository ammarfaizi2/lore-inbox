Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136571AbREAFGR>; Tue, 1 May 2001 01:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136575AbREAFGI>; Tue, 1 May 2001 01:06:08 -0400
Received: from pc-62-30-76-3-az.blueyonder.co.uk ([62.30.76.3]:12804 "EHLO
	mnemosyne.j-harris.dircon.co.uk") by vger.kernel.org with ESMTP
	id <S135903AbREAFF7>; Tue, 1 May 2001 01:05:59 -0400
Date: Tue, 1 May 2001 06:06:07 +0100 (GMT Daylight Time)
From: Jamie Harris <jamie.harris@uwe.ac.uk>
To: <linux-kernel@vger.kernel.org>, Bristol LUG <bristol@lists.lug.org.uk>,
        <linux-admin@vger.kernel.org>
Subject: More!! Kernel NULL pointer, over my head...
In-Reply-To: <Pine.WNT.4.33.0105010538140.-1864577-100000@proteus.j-harris.dircon.co.uk>
Message-ID: <Pine.WNT.4.33.0105010601460.-1864577-100000@proteus.j-harris.dircon.co.uk>
X-X-Sender: j-harris@mercury.uwe.ac.uk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK...

a 'tar xvfz myFile.tar.gz' results in the following in /var/log/syslog

May  1 05:58:11 mnemosyne kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
May  1 05:58:11 mnemosyne kernel: current->tss.cr3 = 01e55000, %cr3 =
01e55000
May  1 05:58:11 mnemosyne kernel: *pde = 00000000

however this time I'm using a different file.  I can however sucessfully
do the following
	gzip -d ; tar xvf myFile.tar.gz

Don't know if that gives anyone any hints...  I haven't changed any
software on the system recently so I don't think it can be a bad tar or
gzip binary.  I get the same for root and non-privileged users.

thanks again.

Jamie...

On Tue, 1 May 2001, Jamie Harris wrote:

> Morning all,
>
> Sorry for the big cross post but I don't have the first clue about where
> to send this one.  I get this from my stock 2.2.18 kernel in
> /var/log/syslog:
>
> May  1 05:27:36 mnemosyne kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000000
> May  1 05:27:36 mnemosyne kernel: current->tss.cr3 = 00362000, %cr3 =
> 00362000
> May  1 05:27:36 mnemosyne kernel: *pde = 00000000
> May  1 05:29:36 mnemosyne kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000000
> May  1 05:29:36 mnemosyne kernel: current->tss.cr3 = 036dc000, %cr3 =
> 036dc000
> May  1 05:29:36 mnemosyne kernel: *pde = 00000000
> May  1 05:30:28 mnemosyne kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000000
> May  1 05:30:28 mnemosyne kernel: current->tss.cr3 = 00ca7000, %cr3 =
> 00ca7000
> May  1 05:30:28 mnemosyne kernel: *pde = 00000000
>
>
> This time it seemed to be caused by running tar on a file, but I've
> noticed a similar error in the past but they've never made anything fall
> over.  The tar process appeared to die but then again so did the telnet
> session so I don't know in what order they went down.  I tried 3 times
> just to check it wasn't a fluke...  What other details would be useful??
>
> Cheers Jamie...
>
> PS I'm not on the linux-kernel list so please post to me directly...

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 ***    Slowly and surely the UNIX crept up on the Nintendo user...    ***
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCS/ED d-(++) s:+ a- C+++>++++$ U+++>$ P++++ L+++>+++++ E+(---) W++ N o?
K? w(++++) O- M V? PS PE? Y PGP- t+ 5 X- R- tv- b++ DI++ D+++ G e++ h*
r++>+++ y+++
------END GEEK CODE BLOCK------

