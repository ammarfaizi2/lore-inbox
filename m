Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316315AbSEODrz>; Tue, 14 May 2002 23:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316316AbSEODry>; Tue, 14 May 2002 23:47:54 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:45574 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316315AbSEODry>;
	Tue, 14 May 2002 23:47:54 -0400
Date: Tue, 14 May 2002 19:46:47 -0700
From: Greg KH <greg@kroah.com>
To: Christer Nilsson <christer.nilsson@kretskompaniet.se>
Cc: lepied@xfree86.org, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.19-pre8  Fix for Intuos tablet in wacom.c
Message-ID: <20020515024646.GA21582@kroah.com>
In-Reply-To: <20020514153735.GB18532@kroah.com> <IBEJLIFNGHPKEKCKODPDMEDODPAA.christer.nilsson@kretskompaniet.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 17 Apr 2002 01:44:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 08:56:14PM +0200, Christer Nilsson wrote:
> Hi Frederic.
> 
> Can you take a look at this?
> 
> I've looked at the code at
> http://people.mandrakesoft.com/~flepied/projects/wacom/ and found that
> there's a couple of lines missing in the kernel driver. It seems that a
> smoothing algorithm is left out
> in the kernel source. My patch just circumvents that.

I took out the smoothing algorithm, as it does not belong in the kernel.
That kind of stuff (filters, etc.) belongs in userspace.

Did my removing it break the current driver accidentally?

thanks,

greg k-h
