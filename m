Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161562AbWAMQnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161562AbWAMQnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161558AbWAMQnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:43:43 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:49264 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161562AbWAMQnm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:43:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nrJFCMd2XUSv576k6l6ropG4yHvWB2HHISjgo7gPu8Vn/6EMZ15iPpyoSw7b5+NVx73sQOOmdZqnJkMJfp9/aBf3SgFbYMzWspR8N6dg314zVxKyZrqiHsAHd24cGjY3jpahvb+q4BC8Q5T4KF4sM9vj6TZoOtDUFv5fCg3TjkU=
Message-ID: <3afbacad0601130843k6cf548e5y638b9ae3434096fa@mail.gmail.com>
Date: Fri, 13 Jan 2006 17:43:40 +0100
From: Jim MacBaine <jmacbaine@gmail.com>
To: Ram Gupta <ram.gupta5@gmail.com>
Subject: Re: /proc/sys/vm/swappiness == 0 makes OOM killer go beserk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <728201270601130832h37eae980hc4e0d3de7522c81e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3afbacad0601130755x507047eeqfdcfb1e54a163cdd@mail.gmail.com>
	 <728201270601130832h37eae980hc4e0d3de7522c81e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Ram Gupta <ram.gupta5@gmail.com> wrote:

> This is ok. When the swappiness variable  is set to zero kernel does
> not try to swap out processes. So once all memory is used up by
> processes it can not free up memory by swapping and hence had to kill
> process.

It _would_ be ok if swappiness == 0 would mean that the kernel will
not swap at all. That's not the case. Even without an excessive use of
tmpfs the kernel found ~250 MB of unused memory which it swapped out
during the last days with swappiness == 0.

Regards,
Jim
