Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbUKIUTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUKIUTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUKIUTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:19:40 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:7784 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261676AbUKIUT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:19:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=c/ysT5WsjmgkRx5HVqjMaeZceadBg9BUF2p8lYQO9XLzdVirgq5kdBytEcK+TMiVtfWhF9zqcySao3fst4iLlzFZIh1UioUEfLEOUYslMC4KG5Y9ynuiUvbSoVEO/7Hnk3vQdjoeDnUaSaA6M8R1d2WsVtZmzqffu/CzD3M/RcY=
Message-ID: <84144f0204110912192c04b8d7@mail.gmail.com>
Date: Tue, 9 Nov 2004 22:19:26 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] kobject: fix double kobject_put() in error path of kobject_add()
Cc: Linus Torvalds <torvalds@osdl.org>, Christian Kujau <evil@g-house.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       matt_domsch@dell.com
In-Reply-To: <20041109190809.GA2628@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <418F6E33.8080808@g-house.de> <418FDE1F.7060804@g-house.de>
	 <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de>
	 <84144f02041108234050d0f56d@mail.gmail.com>
	 <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de>
	 <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org>
	 <20041109190420.GA2498@kroah.com> <20041109190809.GA2628@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, 9 Nov 2004 11:08:09 -0800, Greg KH <greg@kroah.com> wrote:
> Christian, I don't know if this patch explicitly fixes your problem, but
> it fixes problems other people have been having with the driver core
> lately.  I'd appreciate it if you could test it out and let me know if
> it solves your problem, with CONFIG_EDD enabled, or if it doesn't help
> at all.

The broken kobject_add fix is not in -rc1 proper which oopses on
Christian's machine. I don't think this patch has anything to do with
his problem.

                               Pekka
