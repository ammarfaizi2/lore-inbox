Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293513AbSCOXiR>; Fri, 15 Mar 2002 18:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293514AbSCOXiI>; Fri, 15 Mar 2002 18:38:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:19873 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293513AbSCOXhu>; Fri, 15 Mar 2002 18:37:50 -0500
Date: Fri, 15 Mar 2002 15:37:21 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: John Helms <john.helms@photomask.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Trice Jim <Jim.Trice@photomask.com>, Martin.Bligh@us.ibm.com
Subject: Re: bug (trouble?) report on high mem support
Message-ID: <20020315153721.A11753@beaverton.ibm.com>
In-Reply-To: <E16lyLG-0004Zo-00@the-village.bc.nu> <20020315.20324600@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020315.20324600@linux.local>; from john.helms@photomask.com on Fri, Mar 15, 2002 at 08:32:46PM +0000
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,
	What kind of io controllers are on the system? 
	
	To use CONFIG_HIGHIO you need a IO controller the is physically
	capable of addressing higher memory and an adapter driver that has
	been converted to support the CONFIG_HIGHIO interface.

-Mike
John Helms [john.helms@photomask.com] wrote:
> Alan,
> 
> Ok, how do I go about determining that?  The machine
> I have is a brand-spankin' new IBM x-series 350 with
> 4 900MHz Xeon processors.  The system bios can 
> recognize all of the 16320MB of memory at startup.
> If those patches work, it will save our butts as
> we have a major conversion project that hinges on
> this.  
> 
> Thanks,
> jwh
> 
> >>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<
> 
> On 3/15/02, 2:30:22 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote regarding 
> Re: bug (trouble?) report on high mem support:
> 
> 
> > > Here is a top output.  We have 16Gb of ram.
> > > I have also tried a 2.4.9-31 enterprise=20
> > > kernel rpm from RedHat with the same=20
> > > results.
> 
> > Ok that would make sense. Next question is do you have an I/O controller
> > that can use all the 64bit address space on the PCI bus ?
> 
> > What is happening is that you are using a lot of CPU copying buffers down
> > into lower memory to transfer to/from disk - as well probably as that
> > causing a lot of competition for low memory. If your I/O controller can 
> hit
> > the full 64bit space there are some rather nice test patches that should
> > completely obliterate the problem.
> 
> > Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Michael Anderson
andmike@us.ibm.com

