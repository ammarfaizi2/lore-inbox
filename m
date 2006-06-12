Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWFLVjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWFLVjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWFLVjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:39:43 -0400
Received: from rtr.ca ([64.26.128.89]:41868 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932391AbWFLVjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:39:42 -0400
Message-ID: <448DDF1D.5020108@rtr.ca>
Date: Mon, 12 Jun 2006 17:39:41 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jeff Gold <jgold@mazunetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial Console and Slow SCSI Disk Access?
References: <448DDC7F.4030308@mazunetworks.com>
In-Reply-To: <448DDC7F.4030308@mazunetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Gold wrote:
> Does it make sense that enabling a serial console would reduce the 
> bandwidth of a SCSI disk by more than a factor of ten?  This seems crazy 
> to me but there's no arguing with empirical facts.  I have an IBM x345 
> system on which I installed an unmodified 2.6.16.20 kernel built with 
> gcc-4.0.2-8.fc4 (the kernel configuration file I used can be found at 
> http://augart.com/jgold/kconfig).  With the control kernel command line 
> I get about 70 MB/sec with hdparm -t but when I add "console=ttyS0,9600 
> console=tty0" I get about 1.6 MB/sec instead.

This can happen if there are kernel messages being printed on the serial console.
If all is quiet, I would expect things to be as fast as normal elsewhere.

-ml
