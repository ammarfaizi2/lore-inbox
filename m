Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWAaOrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWAaOrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 09:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWAaOrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 09:47:03 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:32168 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750732AbWAaOrB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 09:47:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LtVwD/oGrpDkT6ML43lS+koL4SdeosN5YQr5VmvBUnUExnJ8ei53Uy9e24khn7s8KHQ6cw3Mh6pa/VuPUW0BWv6N1BuaLV8CZCSEo4mTcrGUy6wU6jWspXZGKjXU7a1SG5QedB5+XvkOfTpJt/fkmtR0+8F/y9kyNNiiGq7IXeU=
Message-ID: <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com>
Date: Tue, 31 Jan 2006 15:46:58 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1138714918.6869.139.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138714918.6869.139.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Why cannot existing block layer hook be used for this?

Why are you adding LED_FULL event handling to a specific
device driver (ide-disk) but LED_OFF event handling to a generic
IDE end request function?

This solution has very limited flexibility (disk accesses for
all IDE ports will be registered as coming from the same
source) but I guess it is fine?

Thanks,
Bartlomiej

On 1/31/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> Add an LED trigger for IDE disk activity to the IDE subsystem.
>
> Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
