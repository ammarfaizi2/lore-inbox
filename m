Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSIDRjf>; Wed, 4 Sep 2002 13:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSIDRjf>; Wed, 4 Sep 2002 13:39:35 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:23023 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S310190AbSIDRje>; Wed, 4 Sep 2002 13:39:34 -0400
Date: Wed, 4 Sep 2002 13:44:07 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Joseph N. Hall" <joseph@5sigma.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE-DVD problems [excuse former idiotic topic]
Message-ID: <20020904134407.H1394@redhat.com>
References: <200209041553.g84Frl130632@mx1.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209041553.g84Frl130632@mx1.redhat.com>; from joseph@5sigma.com on Wed, Sep 04, 2002 at 09:11:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 09:11:00AM -0700, Joseph N. Hall wrote:
> Right, but it will work with or without DMA, for some definition
> of "work."  Or it should work, right?

Define "work".  hdparm -d1 doesn't just work, it requires making sure that 
the drive and interface are properly programmed to the correct transfer rates 
first (read as: hdparm -d1 can be Bad).  Using the kernel defaults is much 
better as the probe code will make sure that everything is setup correctly.  
Andre can provide more details and help fix things if it doesn't actually 
work for your drive.

> Do you know anyone who has gotten this particular drive to work?
> Or for that matter if there are any troubles with the KT333
> chipset?  I wouldn't be surprised if there are some interrupt
> "issues" with KT333 because my plain old IDE performance was
> not good under the stock 2.4.18-3 kernel ... it would do some
> of the same things (lots of system time, temporary "pauses",
> etc.).

You might need to upgrade from the -3 kernel (several errata have 
been released) as there were a few known problems with some network 
drivers, as well as NFS and ext3.  Different drives also have varing 
amounts of cache, and it might be this that you're noticing.

> I am also having problems with the C-Media onboard audio +
> ALSA (0.9 rc3) ... it hangs the system (totally) after playing
> for a few seconds.  So that is another strike against this
> particular h/w configuration.

Again, try a newer kernel.  I'm using a C-Media at home and it works 
pretty well for ogg/DVD playback.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
