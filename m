Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290808AbSARUlH>; Fri, 18 Jan 2002 15:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290810AbSARUk6>; Fri, 18 Jan 2002 15:40:58 -0500
Received: from gent-smtp1.xs4all.be ([195.144.67.21]:50959 "EHLO
	gent-smtp1.xs4all.be") by vger.kernel.org with ESMTP
	id <S290808AbSARUkk>; Fri, 18 Jan 2002 15:40:40 -0500
Message-ID: <3C488847.2000800@xs4all.be>
Date: Fri, 18 Jan 2002 21:40:39 +0100
From: Didier Moens <moensd@xs4all.be>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en, nl-be
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS in APM 2.4.18-pre4 with i830MP agpgart
In-Reply-To: <3C487E68.1000404@xs4all.be> <E16RfZf-0007nk-00@the-village.bc.nu> <20020118212843.A6416@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Fri, Jan 18, 2002 at 08:25:19PM +0000, Alan Cox wrote:
> > > Unfortunately, loading agpgart yields an oops when APM ("apm -s") is 
> > > invoked, both in terminal and in X. APM functions perfectly when agpgart 
> > > is absent.
> > Looks like the author forgot to set the suspend/resume methods in the
> > structure to the generic ones
>
>   1373 static int __init intel_i830_setup(struct pci_dev *i830_dev)
>   1374 {
>   1375     intel_i830_private.i830_dev = i830_dev;
>   1376     
> ...
>   1404     agp_bridge.suspend = agp_generic_suspend;
>   1405     agp_bridge.resume = agp_generic_resume;
>

I post an oops, 26'51" minutes later it gets diagnosed, and 3'26" after 
that a patch is submitted.


Quite speechless I am indeed.

Didier








