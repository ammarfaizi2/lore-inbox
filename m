Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVESVOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVESVOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVESVOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:14:50 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:47026 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261262AbVESVOp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:14:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R0qNgoYmBPU4eFj8zE/NhmTjlvDP+ZrTFnz4VvG8TStuX6ZMs/c/tlW8hfJBwrFjeqkrxtWtY80eP8QASm8OZ0Y/asVKaRpdQXRaFzMQ9qNYLKxkq4sv0N+vTGb4V53+RrfNCUpn2JKTFTly0MdDaNEuCoI8yS0/wGv/leLu8nY=
Message-ID: <253818670505191414175ca12@mail.gmail.com>
Date: Thu, 19 May 2005 17:14:44 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Cc: Greg KH <greg@kroah.com>, LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050519220235.3946f880.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705051703479bd0c29@mail.gmail.com>
	 <e9iUj0EZ.1116327879.1515720.khali@localhost>
	 <2538186705051704181a70dbbf@mail.gmail.com>
	 <253818670505172136613abb43@mail.gmail.com>
	 <20050519220235.3946f880.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/05, Jean Delvare <khali@linux-fr.org> wrote:
> I finally gave a try to your patches, including the one for it87 which I
> used for testing. It all works like a charm, pretty impressive
> considering the overall complexity of the change. Congratulations :)

I'm impressed too ;), and very happy to finally have confirmation it
works as planned without blowing up anything.

> I'd like to add that the technical solution you came up with pleases me
> much (which may or may not be relevant).

Well I guess a happy Jean doesn't hurt! I really can't accept full
credit for this though, I think the end solution was a good mix of
ideas/comments from a range of people especially Greg, Russell and
you.

I like the idea of aggregating the related sensor attributes into
arrays, I did things the same way in bmcsensors but of course that was
all dynamic, and would just use more memory if we tried to do that
here. As Greg points out there is probably a nicer way to create the
arrays and register the attributes, but the basic idea has merit I
think, and if we can standardize a method across all the sensors then
its even better.

Thanks,
Yani
