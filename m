Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSBYUDC>; Mon, 25 Feb 2002 15:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292330AbSBYUCv>; Mon, 25 Feb 2002 15:02:51 -0500
Received: from unthought.net ([212.97.129.24]:42940 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S292327AbSBYUCk>;
	Mon, 25 Feb 2002 15:02:40 -0500
Date: Mon, 25 Feb 2002 21:02:39 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Manohar Pradhan <mpml@isp.primuseurope.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Urgent SCSI I/O Error
Message-ID: <20020225210239.H24109@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Manohar Pradhan <mpml@isp.primuseurope.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <194779754037.20020225190953@isp.primuseurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <194779754037.20020225190953@isp.primuseurope.com>; from mpml@isp.primuseurope.com on Mon, Feb 25, 2002 at 07:09:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 07:09:53PM +0000, Manohar Pradhan wrote:
> Hi,
> 
> This question might have been raised before but I am stucked in
> between wierd/helpless situation and wondering if someone can help me
> out.
> 
> I have Red Hat Linux 6.2 (2.2.14-5.0smp) running in my HP Netserver
> box. I have 2 9.1 GB HDD. The server has been up for few months and
> have not had seen any problem. But today all of sudden it gave
> panicking message saying following:
> 
...
> Feb 25 18:48:12 nsdb1 kernel: [valid=0] Info fld=0x0, Current sd08:06: sense key Not Ready
> Feb 25 18:48:12 nsdb1 kernel: scsidisk I/O error: dev 08:06, sector 0
> Feb 25 18:48:12 nsdb1 kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 28000002
> Feb 25 18:48:12 nsdb1 kernel: [valid=0] Info fld=0x0, Current sd08:07: sense key Not Ready
> Feb 25 18:48:12 nsdb1 kernel: scsidisk I/O error: dev 08:07, sector 0

Your disk died.  Physically.

...
> I can access files in all the other partitions but cannot access
> files/directories in partition /www. I can see files in the
> directories listing using 'ls' however accessing any file gives
> Input/Output error saying:
> 
> cat check1.htm: Input/output error
> 

Yep - can't read from bad blocks.

> Can anyone help/suggest me what should I do to make it work? I am
> wondering if I reboot the system, I may fall into problem on booting
> itself. Is there any thing I need to do to make this partition work?

Replace the harddrive, restore from backup.

You will only have a problem booting, if the boot sector / kernel 
resides on that drive - and if that part of the drive is damaged
too.   It seems like that's not the case, but it would be wise
to run an "mkbootdisk" now, just in case.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
