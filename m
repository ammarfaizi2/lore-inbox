Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbUKDUPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbUKDUPB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbUKDUMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:12:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:2187 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262382AbUKDUIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:08:43 -0500
Date: Thu, 4 Nov 2004 11:17:30 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Germano <germano.barreiro@cyclades.com>, Scott_Kilau@digi.com,
       linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041104191730.GA18047@kroah.com>
References: <1099487348.1428.16.camel@tsthost> <20041104102505.GA8379@logos.cnet> <52fz3po8k2.fsf@topspin.com> <20041104174044.GC16389@kroah.com> <52bredmo3f.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52bredmo3f.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 11:05:40AM -0800, Roland Dreier wrote:
>     Roland> I assume this is OK (since there is already one in-kernel
>     Roland> driver doing it), but Greg, can you confirm that it's
>     Roland> definitely OK for a driver to use class_set_devdata() on a
>     Roland> class_device from class_simple_device_add()?
> 
>     Greg> Hm, I think that should be ok, but I'd make sure to test it
>     Greg> before verifying that it really is :)
> 
> Well class_simple.c definitely doesn't use class_data/class_set_devdata()
> now (and as I said drivers/scsi/st.c is using this on a class_simple
> device).  The question is whether you can bless this situation as part
> of the API, or whether some time in the future class_simple might
> start using class_data.

Hey, if it works today, great!  If I, or someone else breaks this in the
future, they they will have to deal with the issue then :)

In short, use it.

thanks,

greg k-h
