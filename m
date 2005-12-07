Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbVLGSfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbVLGSfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbVLGSfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:35:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:29389 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751726AbVLGSfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:35:11 -0500
Date: Wed, 7 Dec 2005 09:56:14 -0800
From: Greg KH <gregkh@suse.de>
To: Eduardo Pereira Habkost <ehabkost@mandriva.com>
Cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-ID: <20051207175614.GA29117@suse.de>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br> <20051207164118.GA28032@suse.de> <20051207145113.4cbdc264.lcapitulino@mandriva.com.br> <20051207171332.GI20451@duckman.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207171332.GI20451@duckman.conectiva>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 03:13:32PM -0200, Eduardo Pereira Habkost wrote:
> I have a small question: in my view, this patch series is a small
> step towards implementing the usb-serial drivers The Right Way, as it
> removes a a bit of duplicated code.

It doesn't remove any "duplicated code", it only changes a spinlock to
an atomic_t for one single value (which I personally do not think is the
best thing to do, and based on the number of comments on this thread, I
think others also feel this way.)

> If we start to do The Big Change to serial_core , probably we would
> make further refactorings on these parts, going towards The Right Way
> to implement the drivers.

Sure, that's the way kernel development is done.

> My question would be: where would the small refactorings belong, while
> the big change to serial_core is work in progress? I would like them
> to go to some tree for testing, while the work is being done, instead
> of pushing lots of changes later, but I don't know if there is someone
> who we could send them.

The "normal" way of doing work like this is, do it somewhere, and then
break it all down into a series of steps, after you have figured out
exactly where you are going to end up.

Feel free to send me any patches that you feel should be applied that
work toward this end goal.

thanks,

greg k-h
