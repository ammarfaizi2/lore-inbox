Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293229AbSCOU3Z>; Fri, 15 Mar 2002 15:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293236AbSCOU3Q>; Fri, 15 Mar 2002 15:29:16 -0500
Received: from usfw01.photomask.com ([198.6.73.7]:50424 "EHLO
	red.photomask.com") by vger.kernel.org with ESMTP
	id <S293229AbSCOU3A> convert rfc822-to-8bit; Fri, 15 Mar 2002 15:29:00 -0500
From: John Helms <john.helms@photomask.com>
Date: Fri, 15 Mar 2002 20:32:46 GMT
Message-ID: <20020315.20324600@linux.local>
Subject: Re: bug (trouble?) report on high mem support
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Jim.Trice@photomask.com (Trice Jim),
        Martin.Bligh@us.ibm.com
In-Reply-To: <E16lyLG-0004Zo-00@the-village.bc.nu>
In-Reply-To: <E16lyLG-0004Zo-00@the-village.bc.nu>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Ok, how do I go about determining that?  The machine
I have is a brand-spankin' new IBM x-series 350 with
4 900MHz Xeon processors.  The system bios can 
recognize all of the 16320MB of memory at startup.
If those patches work, it will save our butts as
we have a major conversion project that hinges on
this.  

Thanks,
jwh

>>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<

On 3/15/02, 2:30:22 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote regarding 
Re: bug (trouble?) report on high mem support:


> > Here is a top output.  We have 16Gb of ram.
> > I have also tried a 2.4.9-31 enterprise=20
> > kernel rpm from RedHat with the same=20
> > results.

> Ok that would make sense. Next question is do you have an I/O controller
> that can use all the 64bit address space on the PCI bus ?

> What is happening is that you are using a lot of CPU copying buffers down
> into lower memory to transfer to/from disk - as well probably as that
> causing a lot of competition for low memory. If your I/O controller can 
hit
> the full 64bit space there are some rather nice test patches that should
> completely obliterate the problem.

> Alan
