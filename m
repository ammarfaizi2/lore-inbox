Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266504AbUFRTDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266504AbUFRTDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266482AbUFRS6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:58:36 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:37791 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S266757AbUFRS5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:57:45 -0400
Date: Fri, 18 Jun 2004 19:57:21 +0100
From: Ian Molton <spyro@f2s.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040618195721.0cf43ec2.spyro@f2s.com>
In-Reply-To: <1087584769.2134.119.camel@mulgrave>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2004 13:52:46 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> 
> You still haven't explained what you want to do though.  Apart from the
> occasional brush with usbstorage, I don't have a good knowledge of the
> layout of the USB drivers.  I assume you simply want to persuade the
> ohci driver to use your memory area somehow, but what do you actually
> want the ohci driver to do with it?  And how much leeway do you get to
> customise the driver.


In *theory* the OHCI driver is doing everything right - its asking for DMAable memory and using it. if the DMA api simply understood the device in question, and alocated accordingly, it would just work.

there are two solutions:

1) Break up the OHCI driver and make it into a chip driver as you describe
2) Make the DMA API do the right thing with these devices

1) means everyone gets to write their own allocator - not pretty
2) means we get to share code and it all just works.
