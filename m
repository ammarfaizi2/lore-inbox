Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSCOXfH>; Fri, 15 Mar 2002 18:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293513AbSCOXe5>; Fri, 15 Mar 2002 18:34:57 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:518 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293510AbSCOXen>;
	Fri, 15 Mar 2002 18:34:43 -0500
Date: Fri, 15 Mar 2002 15:34:42 -0800
From: Greg KH <greg@kroah.com>
To: Gordon J Lee <gordonl@world.std.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
Message-ID: <20020315233441.GG5563@kroah.com>
In-Reply-To: <3C927F3E.7C7FB075@world.std.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C927F3E.7C7FB075@world.std.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 15 Feb 2002 19:01:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 06:09:50PM -0500, Gordon J Lee wrote:
> IBM has a brand new xSeries PC server called the x360.
> It has 1-4 Xeon MP's, DDR SDRAM, PCI-X backplane, IBM Summit chipset.
> Full specs are here:
> 
> http://www.pc.ibm.com/us/eserver/xseries/x360.html

Eeek, these machines are now in the wild?  Didn't realize this :)

> Has anyone tried running Linux on one of these ?

Yes.

> I have tried a few versions and found:
> 
> 2.2.18    fails in boot
> 2.2.20    fails in boot
> 2.2.21rc2 fails in boot

Ouch :(

> 2.4.9     works fine!

Glad to see this.

> I know the hardware is in good shape because a 2.4.9 kernel works
> fine on this machine.  I have scoured the IBM site, linux-kernel,
> and Google for clues, but to no avail.
> 
> The boot sequence failure under the 2.2.x versions that I tried is
> always the same, it fails to recognize the IDE and SCSI devices.  From
> the messages, the system appears to be deaf to interrupts and so it
> cannot recognize its devices.  Notable messages from the boot sequence
> that support this idea are:

I don't know if anyone ever tried a 2.2.x kernel on these boxes :)
Is there a reason you _really_ need a 2.2.x kernel for this machine?

You also might try a UP 2.2.x kernel on this box to see if the problem
is in the parsing of the APIC tables (as I think it is.)

thanks,

greg k-h
