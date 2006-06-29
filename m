Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751828AbWF2ALL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbWF2ALL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWF2ALK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:11:10 -0400
Received: from gw.goop.org ([64.81.55.164]:38857 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751828AbWF2ALJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:11:09 -0400
Message-ID: <44A31A9F.3030102@goop.org>
Date: Wed, 28 Jun 2006 17:11:11 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andy Gay <andy@andynet.net>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB driver for Sierra Wireless EM5625/MC5720 1xEVDO modules
References: <1151537247.3285.278.camel@tahini.andynet.net>
In-Reply-To: <1151537247.3285.278.camel@tahini.andynet.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Gay wrote:
> - these modules present 3 bulk EPs, the 2nd & 3rd can be used for
> control & status monitoring while data transfer is in progress on the
> 1st EP. This is useful (and necessary for my application) so we need to
> increase the port count.
>   
Ooh, can you share the details of those EPs?  Is your application public?

> So what should I do next? I see a few possibilities, assuming anyone is
> interested in this:
>
> - I could post a diff from Greg's driver. But I don't have hardware to
> test whether my changes will break it for the other devices that it
> supports;
>   
Well, it is specifically an airprime driver.  My card also presents 
another two endpoints, but I don't know what to do with them, so I 
haven't worried about them too much.  If they all talk the same thing, 
then they may as well be in the same driver.

Are you proposing adding some more protocol knowledge to airprime, or 
just make those EPs appear as more serial ports?

Thanks,
    J
