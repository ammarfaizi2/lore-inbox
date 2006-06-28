Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWF1Xj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWF1Xj6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWF1Xj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:39:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:3101 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751494AbWF1Xj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:39:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CxM3BwGwBzExqrO62r5Jp0DIAYkAfGFFNtIyY18f+o1/ucWkGfeFgX2OaQ7yGCjHSt7NPQAj7lNsnmuhn59jSJ28ECLSDY/Nr2G9C8LbFkx1BpC+vjmSxzyBLwciAWV/HLuByXKmffMijh3sY9mVcMJt1ZuvGPcQoa6jW8EOJJI=
Message-ID: <9e4733910606281639u26fbf62apbb01067a0d99c072@mail.gmail.com>
Date: Wed, 28 Jun 2006 19:39:56 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] move MAX_NR_CONSOLES from tty.h to vt.h
Cc: lkml <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <44A30D9D.5060804@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910606271203w4ceb6216g92f5fefee654aaf3@mail.gmail.com>
	 <44A30D9D.5060804@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > MAX_NR_CONSOLES is more of a function of the VT layer than the TTY
> > one. Moving this to vt.h allows all of the framebuffer drivers to
> > remove their dependency on tty.h. Note that console drivers in
> > video/console still depend on tty.h but fbdev drivers should not
> > depend on the tty layer.
>
> In fact, none of the VT console drivers should have any dependency
> on tty.h, only vt.c should.
>
> I think, the only thing needed by fbcon (and all other drivers in
> drivers/video/console) in tty.h is fg_console. We can move that
> to vt_kern.h instead.

Do you want to take over this patch and merge it via your tree? Do you
want to move fg_console or do you want me to?

The patch in this message is related.
[PATCH] remove include of screen_info.h from tty.h

-- 
Jon Smirl
jonsmirl@gmail.com
