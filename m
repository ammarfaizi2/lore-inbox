Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271269AbUJVNQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271269AbUJVNQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269109AbUJVNQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:16:53 -0400
Received: from sd291.sivit.org ([194.146.225.122]:23684 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S271269AbUJVNQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:16:40 -0400
Date: Fri, 22 Oct 2004 15:16:39 +0200
From: Luc Saillard <luc@saillard.org>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: Re: Linux 2.6.9-ac3
Message-ID: <20041022131639.GC16963@sd291.sivit.org>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it> <20041022092102.GA16963@sd291.sivit.org> <20041022143036.462742ca.luca.risolia@studio.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022143036.462742ca.luca.risolia@studio.unibo.it>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 02:30:36PM +0200, Luca Risolia wrote:
> Either port the driver to V4L2, which handles decompression stuff well,
no, it only provide a number (that needs to be reserved) to the user API, but
if the user API doesn't exist, application will not support your camera. I
can provide a .c and .h for the decompression module, but since the
decompression table depend of the resolution,quality choose by the webcam
(thinks as quality fine,normal,low). I can't provide with v4l2 a generic
control for this.
> or provide a separate downloadble GPL'ed module. Other drivers in the
> mainline kernel observe this rule; the pwc case is not an exception.
The driver, in it's current status, is GPL. Can you give me some examples
about "other drivers" ?
> Also, this matter has been already discussed many times in the v4l
> mailing list: no video decompression at all in kernel space, even if
> *optional* through an *indipendent* module.
It's easy for you to say that, because your driver returns a native format.
Since nobody cares about webcam, and stream compressed, if today, i remove
the table in the module, i'll wait one year ? two years for app that support
my webcam ?
> I doubt Morton or Linus will ever accept this version of pwc driver, since
> they did accept a patch disabling colorspace conversion from a driver
> recently.
my driver only output a standart video stream, i don't convert colorspace.
Decompression ops use table and offset in this table. The one thing i agree
about decompression, is for kernel preemption.

> It sounds logic that none would help to fix user applications, if
> we kept including things like decompression in each module in the kernel.
And it's logic too, to let the driver do the decompression because you WANT
your device working. So please, i want to remove decompression, but i want
people be able to use camera. People have trouble to compile the module
outside of the kernel (and you just need to type make; make install). If you
need to compile, gnomeeting, kame, kde, xawtv yourself to use the camera,
i'll not able to take time to add features on this drivers. 
 
Luc

