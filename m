Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSFNSxJ>; Fri, 14 Jun 2002 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315929AbSFNSxI>; Fri, 14 Jun 2002 14:53:08 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:21744 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S314548AbSFNSxG>; Fri, 14 Jun 2002 14:53:06 -0400
Date: Fri, 14 Jun 2002 14:53:07 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: john stultz <johnstul@us.ibm.com>
Cc: marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [Patch] tsc-disable_A5
Message-ID: <20020614145307.G22888@redhat.com>
In-Reply-To: <1024079726.29929.131.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 11:35:26AM -0700, john stultz wrote:
> This results in sequential calls to gettimeofday to return
> non-sequential time values. By disabling the TSCs on these boxes, it
> forces gettimeofday to use the PIC clock instead, fixing the problem. 

This seems to be yet another reason for supporting per-CPU TSC 
calibration, as that would fix machines with different speed cpus, too.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
