Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132767AbRDNHFM>; Sat, 14 Apr 2001 03:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132770AbRDNHEw>; Sat, 14 Apr 2001 03:04:52 -0400
Received: from npt12056206.cts.com ([216.120.56.206]:47113 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S132767AbRDNHEk>; Sat, 14 Apr 2001 03:04:40 -0400
Date: Sat, 14 Apr 2001 00:04:33 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: SW-RAID0 Performance problems
Message-ID: <20010414000433.F4557@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10104131048550.1669-100000@coffee.psychology.mcmaster.ca> <01041317365500.00665@debian> <20010413090751.E4557@greenhydrant.com> <01041318282003.00665@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01041318282003.00665@debian>; from ujq7@rz.uni-karlsruhe.de on Fri, Apr 13, 2001 at 06:28:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 06:28:20PM +0200, Andreas Peter wrote:
> Am Freitag, 13. April 2001 18:07 schrieb David Rees:
> 
> > Cconfig and setup looks OK.
> >
> > What happens if your run hdparm -t /dev/hda and /dev/hdc at the same time?
> 
> Good idea!
> The performance is only ~11MB/sec per disk
> There is a bottleneck somewhere...

OK, so it's not the RAID setup.  There's two things that can cause this.  
One is that DMA is turned off  (what does hdparm /dev/hda and hdparm 
/dev/hdc show?), the second was that the drives are on the same channel 
(which obviously isn't the case here).  Can you verify that the drives are 
in DMA mode?

-Dave
