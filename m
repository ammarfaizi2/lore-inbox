Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVBQEho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVBQEho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 23:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVBQEho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 23:37:44 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:32144 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262209AbVBQEhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 23:37:33 -0500
Subject: Re: i810 BUG summary. Was Re: [SoftwareSuspend-devel] [Announce] 
	2.1.7 for 2.6.11-rc4
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: mhf@berlios.de,
       FrameBuffer Devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: SoftwareSuspend Development 
	<softwaresuspend-devel@lists.berlios.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz,
       akpm@osdl.org
In-Reply-To: <42141C01.nail5A31PHQ9L@berlios.de>
References: <42141C01.nail5A31PHQ9L@berlios.de>
Content-Type: text/plain
Message-Id: <1108615165.4471.13.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 17 Feb 2005 15:39:25 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael.

Perhaps this belongs with the framebuffer devel guys? I'll copy them
now. Antonio et al, have I called it right?

Regards,

Nigel

On Thu, 2005-02-17 at 15:22, mhf@berlios.de wrote:
> Hi Nigel!
> 
> On Wednesday 16 February 2005 05:22, Nigel Cunningham wrote:
> > Hi Michael.
> >
> > On Tue, 2005-02-15 at 22:32, mhf@berlios.de wrote:
> > > - Removing intel-agp as well fixes the problem and X
> > > can be started alright after resume.
> >
> > Did you see Karol's patch? It looks like it should
> > improve your situation.
> 
> It did :-)
> 
> >
> > Did you get any joy out of the posting to LKML?
> >
> 
> Yes, Andrew suggested privately thqt screen should come back
> as prior to S3 and Pavel sees the setfont issue as a bug.
> 
> 2.6.11-rc4 i810 bugs:
> 
> 1) Screen comes back in 25 line mode but scroll remains at
> last set linecount. (also on all other displays tested like 
> savage or sis or via.
> 
> 2) setfont dies on resume from S3.
> 
> 3) A scroll problem in console mode with gentoo portage and
> likely othe apps which scroll lines of random length 
> 
> 4) With X wo DRM random colored bands flash over the screen 
> when running some programs and shellscripts as if it would 
> send the data bus instead of video data to the DAC. A 
> swsusp2 cycles fixes it until the next S3 cycle.
> 
> 5) Then DRM (20050211 snapshot) dies on resume.
> 
> Guess it's time to find an i810 datasheet and go digging.
> 
> Otherwise, No issues seen wrt swsusp 2.1.7 on 2.6.11-rc4.
> 
> Good news is that S3 seems to be quite stable also when 
> interleaved with swsusp2. There were no failures. 
> 
> Lastly, I'd like to see the ACPI alarm function work to do 
> stress testing in a loop:
> 
> 1) set alarm to current time + xx sec
> 2) enter S3 or S4/swsusp2
> 3) on resume triggered by alarm continue from step 1.
>   
> Regards
> Michael
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

