Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVG2RnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVG2RnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVG2RnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:43:07 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:10686 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262641AbVG2RnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:43:05 -0400
Date: Fri, 29 Jul 2005 13:43:05 -0400
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
Message-ID: <20050729174305.GV6714@csclub.uwaterloo.ca>
References: <C349E772C72290419567CFD84C26E017042058@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C349E772C72290419567CFD84C26E017042058@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 11:05:50PM +0530, Mukund JB. wrote:
> camera formatted info
> ----------------------
> Disk /dev/tfa0: 448 cylinders, 2 heads, 32 sectors/track
> Units = cylinders of 32768 bytes, blocks of 1024 bytes, counting from 0
> 
>    Device Boot Start     End   #cyls    #blocks   Id  System
> /dev/tfa0p1   *      0+    449     450-     14371+   1  FAT12
> /dev/tfa0p2          0       -       0          0    0  Empty
> /dev/tfa0p3          0       -       0          0    0  Empty
> /dev/tfa0p4          0       -       0          0    0  Empty
> Warning: partition 1 extends past end of disk

Why excactly does the partition table say 450 cylinders when the kernel
believes it to be 448 cylinders?  Someone is wrong.  Either the device
was partitioned wrong and hence formated wrong, or whatever driver the
kernel is using to read it is broken and returns the wrong size for the
device.

I have never heard of /dev/tfa0p* either.  What is that?

> Windows formatted info
> ----------------------
> Disk /dev/tfa0: 448 cylinders, 2 heads, 32 sectors/track
> Units = cylinders of 32768 bytes, blocks of 1024 bytes, counting from 0
> 
>    Device Boot Start     End   #cyls    #blocks   Id  System
> /dev/tfa0p1   *      0+    449     450-     14371+   1  FAT12
> /dev/tfa0p2          0       -       0          0    0  Empty
> /dev/tfa0p3          0       -       0          0    0  Empty
> /dev/tfa0p4          0       -       0          0    0  Empty
> Warning: partition 1 extends past end of disk

Identical.  Sure makes it look like a driver error on the linux side in
that case.

Len Sorensen
