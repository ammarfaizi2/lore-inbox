Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752122AbWCJAcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbWCJAcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbWCJAcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:32:19 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:31409 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752122AbWCJAcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:32:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NTW0NmYSkTCl6ak+FAQ6gVpS/4PmBxXB3oRJ03lfPO/O0LJl3+ooUoxuboLaacJDw2y1KyNRN2tqbsgURtU/R7CORl0HgC8cze/BVjiw3pAv4tYmkFulevVpnWHrFoP3z+bAoX3yMcT0jhLcheIEeFwv6MMDp8UyaLbCTLoMDIQ=
Date: Fri, 10 Mar 2006 03:32:13 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jason Brian Friedrich <mail@lockfile.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Booting Kernel 2.6.15 let the machine freeze completely
Message-ID: <20060310003213.GA7789@mipter.zuzino.mipt.ru>
References: <4410B86E.9060809@lockfile.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4410B86E.9060809@lockfile.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 12:21:18AM +0100, Jason Brian Friedrich wrote:
> I tried Kernel 2.6.15 in many different variations, from boot cds,
> live cds, (i.e. Gentoo 2006.0, Ubuntu Dapper) compiled one myself with
> several configurations, with RAMdisk and without. But everytime the
> same result.
>
> With the parameters "noapic nolapic acpi=off" the systems freezes
> after the text line "Booting kernel......". When i use the parameters
> "noapic nolapic acpi=offpci=usepirqmask" i get a bit further in the
> booting process and get these lines before the system freezes completely:
>
> io scheduler deadline registered
> io scheduler cfq registered
>
> A screenshot of this moment is available at
> http://lockfile.org/upload/dapper_error.jpg and was made when trying
> an Ubuntu Dapper live-CD. It is the same error messaage i receive with
> various other boot or live cds, even with the self-compiled kernel.
> The cds work absolutely fine on my two other system around. I also
> have the last available BIOS version on my system. Because of the
> "2.6.15 issue", i had to collect the output below from my running
> 2.6.14 on Fedore Core 4.

Brave Fedora users comment more:
----------------------------------------------------------------------
mine did the same exact thing on test 2., hung at cfq scheduler, but
this is on a Abit KU8 motherboard with a sempron 64 processor, and it
did it on every distro using a 2.6.15 kernel that I tried, yet 2.6.14
and below were fine, I think there is a problem with the 2.6.15 series
of kernel rather than a media issue, because when gentoo moved to
2.6.15, it stopped on cfq and that was an install over a year old, not
coming off the cd, plus thier new installer,,,, based on .*.15 kerel
wont start for me either, stopping at cfq or right after "loading
kernel....done"
-----------------------------------------------------------------------
Try these boot options at startup:
noapic acpi=off nofb
-----------------------------------------------------------------------
It Worked!
-----------------------------------------------------------------------
It stops right at:
"io scheduler cfq registered".
opensuse 10 has been giving me a similar problem

And for details, this was an x86_64 version on a abit KU8 motherboard
(died two weeks after I got it) using an AMD 64 3700.
-----------------------------------------------------------------------
I am having the same issue with my ku8 board w/3700amd64, possible
connection? it is giving me the same freezup at cfq scheduler, and it
started when I upgraded to 2.6.15 in core 4/ and on the dvd iso of fc5
test 2
-----------------------------------------------------------------------
I get exactly the same problem. I'm using a shuttle stg205 with ati 2000
xpress chipset and AMD 64 3200. I have had this problem ever since the
2.6.15 kernels.

