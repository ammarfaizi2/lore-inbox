Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSHGEmy>; Wed, 7 Aug 2002 00:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSHGEmy>; Wed, 7 Aug 2002 00:42:54 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:33810 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316996AbSHGEmx>;
	Wed, 7 Aug 2002 00:42:53 -0400
Date: Tue, 6 Aug 2002 21:43:48 -0700
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB root hub polling and suspend
Message-ID: <20020807044348.GA11412@kroah.com>
References: <15696.21218.406438.634687@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15696.21218.406438.634687@argo.ozlabs.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 10 Jul 2002 03:40:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 08:51:14AM +1000, Paul Mackerras wrote:
> Currently with 2.5, when I suspend and resume my powerbook, I find
> that the USB subsystem no longer sees root hub events, i.e. it doesn't
> notice when I plug in a new USB device (it doesn't notice when I
> unplug a device either but of course the driver for the device sees
> that it is no longer responding).
> 
> It turns out that what happens is that the root hub timer goes off
> after the OHCI driver has done its suspend stuff.  The timer routine
> sees that the HCD is not running at the moment and doesn't schedule
> another timeout.  Hence the series of timeouts stops.
> 
> The patch below fixes the problem for me.  Comments welcome.

Thanks, I've added it to my tree and will send it on to Linus.

greg k-h
