Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVCJPDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVCJPDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVCJPDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:03:48 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:51855 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262623AbVCJPDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:03:47 -0500
Subject: Re: Linux 2.6.11-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42300E31.5030301@tupshin.com>
References: <1110231261.3116.90.camel@localhost.localdomain>
	 <20050309072646.GG1811@zip.com.au>
	 <58cb370e05030908267f0fadbe@mail.gmail.com>
	 <1110386321.3116.196.camel@localhost.localdomain>
	 <58cb370e050309084374f93a71@mail.gmail.com>
	 <20050309222232.GH1811@zip.com.au>
	 <1110407945.3072.272.camel@localhost.localdomain>
	 <42300E31.5030301@tupshin.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110466897.28860.291.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 10 Mar 2005 15:01:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-03-10 at 09:06, Tupshin Harper wrote:
> Alan...since you disagreed with the earlier characterization of what it 
> would take to get into the mainline kernels, could you let us know what 
> it would take in your opinion? FWIW, I'm happily using it with a -ac kernel.

It needs some small changes in the base ide-disk code to handle drives
having only a logical geometry (legal but Linux can't cope). Most if not
all the other hooks are there to an extent the driver for the it821x can
work without core code changes. It might be cleaner with core changes
but it's better that the it821x code handles the weirdness of the
hardware.

Longer term it (and probably every other IDE PATA driver) should be
moved to the Jeff Garzik SATA layer. That's also Bart's position I
believe ?

