Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136566AbREDXP4>; Fri, 4 May 2001 19:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136567AbREDXPr>; Fri, 4 May 2001 19:15:47 -0400
Received: from femail17.sdc1.sfba.home.com ([24.0.95.144]:45704 "EHLO
	femail17.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136566AbREDXPa>; Fri, 4 May 2001 19:15:30 -0400
Message-ID: <3AF33665.A8B8EC0A@didntduck.org>
Date: Fri, 04 May 2001 19:08:21 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chip Schweiss <chip@innovates.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Setting kernel options at compile time.
In-Reply-To: <H00000650007236c.0989014582.dublin.innovates.com@MHS>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Schweiss wrote:
> 
> I'm trying to get a 2.2.19 kernel loaded on an i810 system using RPLD on
> a diskless system.  I can get the kernel loaded and running.  The
> problem is the i810 needs the kernel parameter "mem=xxxM" set to tell
> the kernel how much memory the system has since the on the i810 the
> kernel doesn't know how much was taken for video.
> 
> The catch I'm running into is RPLD cannot pass parameters to the kernel
> and without this setting the system has video problem, most likely from
> the memory sharing issues.  When the mem parameter is set when using a
> disk it doesn't demonstrate any problems.
> 
> What I'm trying to figure out is how to compile in this setting.
> 
> Thanks,
> Chip Schweiss

Try a 2.4 kernel.  If the BIOS is reserving memory for the video card it
should show up in the e820 memory map.  2.2.x last I checked doesn't use
e820 for memory detection.

-- 

						Brian Gerst
