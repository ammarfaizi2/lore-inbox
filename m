Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTDSS3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 14:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTDSS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 14:29:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27552 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263426AbTDSS3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 14:29:22 -0400
Date: Sat, 19 Apr 2003 19:41:20 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-ID: <20030419184120.GH669@gallifrey>
References: <20030419180421.0f59e75b.skraw@ithnet.com> <87lly6flrz.fsf@deneb.enyo.de> <20030419200712.3c48a791.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419200712.3c48a791.skraw@ithnet.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.66 (i686)
X-Uptime: 19:28:58 up 1 day,  7:29,  1 user,  load average: 0.15, 0.25, 0.21
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Besides the problem that most drive manufacturers now seem to use
cheese as the data storage surface, I think there are some other
problems:

  1) I don't trust drive firmware.
	2) I don't think all drives are set to remap sectors by default.
	3) I don't believe that all drivers recover neatly from a drive error.
	4) It is OK saying return the drive and get a new one - but many of
	   us can't do this in a commercial environment where the contents of
		 the drive are confidential - leading to stacks of dead drives
		 (often many inside their now short warranty periods).
		 
To be fair I'm not sure if it is only the drive firmware I don't trust -
it could be the controllers and the IDE drivers as well - I don't know.

While RAID works well for drives that just go pop and die, for drives
with dodgy firmware we just sit there and watch the filesystems decay.
I don't think the kernel can do much about that - but it is a sad state.

I'd find two things useful in this respect:
  1) A tool to check the consistency of a RAID - presuming I shut my
	RAID down safely I should actually be able to use the redundant
	information to test it; this should reveal corruption early.
	(Perhaps the kernel could check a few sectors a second in the
	background)

	2) A disc exerciser - something that I can use to see if this drive,
	connected to this controller, on this motherboard on this kernel
	actually works and keeps its data safe before I put it into live
	service.

Dave (After a few weeks of fighting pissy IDE hard drives)

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
