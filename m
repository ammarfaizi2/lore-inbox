Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBVAZo>; Wed, 21 Feb 2001 19:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129603AbRBVAZe>; Wed, 21 Feb 2001 19:25:34 -0500
Received: from [209.102.105.34] ([209.102.105.34]:51460 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129170AbRBVAZ2>;
	Wed, 21 Feb 2001 19:25:28 -0500
Date: Wed, 21 Feb 2001 16:24:49 -0800
From: Tim Wright <timw@splhi.com>
To: Fons Rademakers <Fons.Rademakers@cern.ch>
Cc: linux-kernel@vger.kernel.org, andre@suse.com
Subject: Re: had: lost interrupt...
Message-ID: <20010221162449.B2118@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Fons Rademakers <Fons.Rademakers@cern.ch>,
	linux-kernel@vger.kernel.org, andre@suse.com
In-Reply-To: <20010217100820.A16593@pcsalo.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010217100820.A16593@pcsalo.cern.ch>; from Fons.Rademakers@cern.ch on Sat, Feb 17, 2001 at 10:08:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You didn't give the (likely more) important part of your .config, but I'll bet
that you have CONFIG_APM_ALLOW_INTS disabled. Turn it on, rebuild and reboot.
At least on a Thinkpad T20, trying to use UDMA, and APM without APM_ALLOW_INTS
enabled gives an 'hda: lost interrupt'. Even worse, I didn't hang, but was able
to go on and trash my hard drive :-(
With CONFIG_APM_ALLOW_INTS turned on, everything behaves nicely.

Tim

On Sat, Feb 17, 2001 at 10:08:21AM +0100, Fons Rademakers wrote:
> Hi,
> 
>    in my laptop (HP 4150B) I upgraded from a 12GB IBM Travelstar to an
> 20GB IBM Travelstar (both 4200rpm). After the upgrade I moved also to
> 2.4.2-pre3 and reiserfs. However, the problem I now have is that after
> resume I get the message "hda: lost interrupt" and the only thing to do
> is to reset the machine (in the only good thing is that reiserfs saved
> me a lot of fsck time).
> 
> Any idea what the problem might be? Is the larger disk not supported by
> the BIOS (it is recognized properly). People mentioned not to use DMA
> anymore?
> 
> With 2.2.18 and the 12GB disk there were never problems (except that the
> disk got bad blocks ;-().
> 
> My IDE setup in .config is below.
> 
> 
> Cheers, Fons.
> 
[IDE config elided]

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
