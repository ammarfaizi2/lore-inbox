Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVCJO6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVCJO6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 09:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVCJO6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 09:58:50 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:35561 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262622AbVCJO6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 09:58:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AGsKmpa5Kg/VqftH6JHZVoIEK8d0fGeezsR0ar7iAQNCw8BvfCzJrd8qLiKkeDe+uKYwOEY7ssh7Cs+1bG0ier8guMUHtq9CdCa99PYHnVzYXSMYepK1drWmQ8s89YU+fJgN9C6KCmpt7fjWIMWb/er464gptRPDZK81+0qJZN4=
Message-ID: <9e4733910503100658ff440e3@mail.gmail.com>
Date: Thu, 10 Mar 2005 09:58:10 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: current linus bk, error mounting root
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310075049.GA30243@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105030909031486744f@mail.gmail.com>
	 <422F2F7C.3010605@pobox.com>
	 <9e4733910503091023474eb377@mail.gmail.com>
	 <422F5D0E.7020004@pobox.com>
	 <9e473391050309125118f2e979@mail.gmail.com>
	 <20050309210926.GZ28855@suse.de>
	 <9e473391050309171643733a12@mail.gmail.com>
	 <20050310075049.GA30243@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LABEL=/                 /                       ext3    defaults        1 1
label / is on /dev/sda6

Creating root device
Mounting root filesystem
mount: error 6 mounting ext3
mount: error 2 mounting none
Switching to new root
Switchroot: mount failed 22
umount /initrd/dev failed: 2

This is what is left on the screen when the boot fails. There is a
another line about failed to mount root machine halted.

I am still broken with using the Linus bk tree as of when I wrote this
mail. That should be all of bk6 plus anything that came in this
morning.



On Thu, 10 Mar 2005 08:50:53 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Wed, Mar 09 2005, Jon Smirl wrote:
> > On Wed, 9 Mar 2005 22:09:26 +0100, Jens Axboe <axboe@suse.de> wrote:
> > > probably not worth the bother, looks like barrier problems. get the
> > > serial console running instead and send the full output, I'll take a
> > > look in the morning.
> >
> > serial console boot output attached.
> 
> Hmm ok, nothing of interest there. What does the mount error 6 and 2
> from  your original mail mean? I need some more info on what fails
> specifically. What mount options are used? What partition is mounted (is
> it md or hdaX)?
> 
> I'm not sure -bk5 had the follow up fix patch for the barrier rework,
> you should probably just retry with -bk6 first.
> 
> --
> Jens Axboe
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
