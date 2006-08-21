Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWHUCrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWHUCrc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 22:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWHUCrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 22:47:32 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:42806 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932522AbWHUCrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 22:47:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pSDVtH09Zm7qqk6Q5hS/AQiNGvCR89CuFKbENnBoTHVstio57zQKuh40waknfFb8Ib03yxPoHDhH92d7R2h+8uV6nbfK4/5oL76Awj08cieTBdd14s63rJPymsScI7te2Yw4jCPJwepNG5vPZ0JKpWQiwAh+wtIMd0y4rkf4hIg=
Message-ID: <18d709710608201947r59c83c92vfd3f2476b705053b@mail.gmail.com>
Date: Sun, 20 Aug 2006 23:47:30 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: "Solar Designer" <solar@openwall.com>
Subject: Re: [PATCH] loop.c: kernel_thread() retval check
Cc: "Willy Tarreau" <w@1wt.eu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060821023217.GA23416@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060819234629.GA16814@openwall.com>
	 <1156097717.4051.26.camel@localhost.localdomain>
	 <20060820223442.GA21960@openwall.com>
	 <1156115468.4051.80.camel@localhost.localdomain>
	 <20060820225823.GD602@1wt.eu>
	 <18d709710608201859o7f1c8075wab0e71cd85814967@mail.gmail.com>
	 <20060821023217.GA23416@openwall.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/06, Solar Designer <solar@openwall.com> wrote:
> You need to make sure that the cleanup code added with the patch matches
> the loop device initialization preceding the kernel_thread() call.  You
> should not blindly take the cleanup code out of the 2.4 patch and apply
> it to 2.6 - it might not be correct for 2.6.

Yes, I already had that in mind, but thanks for the worry, anyway.

> No.  But you won't be able to reproduce this with strace on 2.6 since
> 2.6's kernel_thread() uses CLONE_UNTRACED instead of failing on ptrace.
> You'll probably need to temporarily replace the kernel_thread() call in
> loop.c with -EAGAIN to comfortably test your cleanup code without
> forcing the system to run out of resources.

Thanks for the tip. I'll see what I can do. :)

Cheers,

    Julio Auto
