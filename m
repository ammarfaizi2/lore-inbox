Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRCZXPM>; Mon, 26 Mar 2001 18:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRCZXPD>; Mon, 26 Mar 2001 18:15:03 -0500
Received: from mout0.freenet.de ([194.97.50.131]:58271 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S129669AbRCZXOo>;
	Mon, 26 Mar 2001 18:14:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Franck <afranck@gmx.de>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: ATAPI burner and IDE SCSI emulation
Date: Tue, 27 Mar 2001 01:13:56 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01032701135600.13773@dg1kfa>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,

after having "upgraded" (?) my distro from my wonderfully hand-configured 
Debian system (which I unfortunately wrecked up lately) to S*SE 7.1, I'm now 
really displeasured about the IDE-SCSI emulation thing for my ATAPI CD 
roaster. Not that I was not able to set it up correctly, but being a bit 
fastidious and used to be able to configure almost everything I wanted, 
including what drivers I wanted to load, by choosing modules I was deeply 
disappointed about the sof the IDE SCSI emulation driver, which seems really 
baroque. 

For the unknowing, here are the general "newbie" steps nneded to make a 
simple ATAPI CD roaster roast at all: Compile the kernel with IDE-SCSI 
support enabled (or as a module), then you have to pass a mysterious 
"hdx=ide-scsi" on the kernel commandline (through LILO or whatsoever), then 
the "normal" IDE driver refuses to take any control over your CD burner. This 
makes it possible for the IDE SCSI driver to take this job.

To actually USE my burner, it even gets more complicated (... I always speak 
for the "Joe Blow" user, I have gone through all this and succeeded 
finally...) - I have not only to load the SCSI CD-ROM driver to be able to 
read any CDs with the burner, reset the /dev/cdrom (or /dev/cdburner) link 
accordingly, but I also need this mysterious generic SCSI module loaded...

People, my say this is the biggest mess of configuration for me since I last 
built up my first WNOS TCP/IP system, which was 7 years ago. And this is my 
mission:

Clean this mess up. Make CD roasting work fine without this SCSI crap (sorry, 
no offense intended, but from the "user perspective" its friendliness goes 
far to -ininity...)

I'd appreciate any comments, am willing to take big slaps on my head from any 
major wood part, and would like to know if anything/anyone is already working 
towards this, or is doing any other tasks in this area.

Im particular I'd better look at the packet writing stuff (who's involved? 
Jens Axboe?) before I start anything too big :) Again, any comments or 
pointers to other projects are welcome, I can't wait to be able to toast CDs 
on my machine without going through this nightmare again :-)

Greetings (and: please don't take anything personal or too serious, it's just 
me being frustrated after having set up my system and nothing working 
again...)

Andreas
