Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284111AbRLYAje>; Mon, 24 Dec 2001 19:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284118AbRLYAjY>; Mon, 24 Dec 2001 19:39:24 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:57742 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S284111AbRLYAjN>;
	Mon, 24 Dec 2001 19:39:13 -0500
Date: Tue, 25 Dec 2001 01:39:02 +0100
From: Christian Ohm <chr.ohm@gmx.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
Message-ID: <20011225003901.GA3752@moongate.thevoid.net>
In-Reply-To: <20011224010450.GB1482@moongate.thevoid.net> <Pine.LNX.4.33.0112232355540.5312-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112232355540.5312-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.24i
Organization: theVoid
X-Operating-System: Linux moongate 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drives from different vendors often don't get along on the same channel;
> you should definitely try disconnecting the cdrom.

judging by the look of the drives, quantum was bought by maxtor (i think
they really did); they look nearly identical. but i'll try to connect them
to different channels and use a new cable. and the cdrom is a scsi drive...

> if you have a kt133/kt133a/kt266/kt266a, you should probably look for:
> 
> PCI: Probing PCI hardware
> Trying to stomp on Athlon bug...
> Unknown bridge resource 0: assuming transparent
> PCI: Using IRQ router VIA [1106/0686] at 00:04.0
> Applying VIA southbridge workaround.

for me, it looks like this:

PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Disabling Via external APIC routing

> (the second and fifth lines are relevant, though it depends on which
> particular chips you have as to whether you should see them.)

nothing about athlons (i have a duron, though this shouldn't make a
difference)...

> rest assured that this is specific to your config.  there are many, 
> many perfect-functioning linux boxes out there, along with probably
> several tens of thousands running 2.4.17 already.

yeah, i know... and that's what makes this so difficult to track down...

it doesn't seem to be a hardware problem. i copied about 15gb from the old
to the new drive (with linux, on fat32 partitions). i diff'ed them, just to
be sure, and not a single file was corrupted... the only corruption i found
was on reiserfs partitions (though my ext2 partition is only 50mb). i ran
the maxtor power diagnostics, including a 6 hour burn in test, and it said
the drive works perfectly... i'm really out of ideas here...

bye
christian ohm
