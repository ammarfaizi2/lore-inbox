Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314801AbSEHSV7>; Wed, 8 May 2002 14:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSEHSV6>; Wed, 8 May 2002 14:21:58 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:40966 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314787AbSEHSV4>;
	Wed, 8 May 2002 14:21:56 -0400
Date: Wed, 8 May 2002 10:22:01 -0700
From: Greg KH <greg@kroah.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Padraig Brady <padraig@antefacto.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020508172201.GG11620@kroah.com>
In-Reply-To: <Pine.LNX.4.44.0205070827050.1343-100000@home.transmeta.com> <3CD800FE.4050004@antefacto.com> <3CD8D57B.4080702@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 10 Apr 2002 15:28:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 09:36:27AM +0200, Martin Dalecki wrote:
> >
> >For e.g. could the same arguments could be made for lspci only
> >interface to pci info rather than /proc/bus/pci? The following
> >references are made to /proc/bus/pci on my system:
> 
> In esp. in sigth of the fact that we have a device tree filesystem, I
> rather think that /prco/bus/pci is obsolete indeed.

Not quite yet.  I considered moving the functionality of /proc/bus/pci
into driverfs, but couldn't find a good solid reason to do it (and it
would involve changing lspci and any other userspace programs that use
it today.)

Now reimplementing /proc/bus/pci as a stand alone filesystem mounted in
that position (like usbfs is) is another story.  pcifs anyone?  :)

thanks,

greg k-h
