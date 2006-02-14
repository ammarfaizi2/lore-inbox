Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWBNLQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWBNLQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWBNLQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:16:21 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:29769 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161008AbWBNLQU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:16:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nwjc8N1b6ZIjLgnryyRK3Hy8oKYbiFqnwE/0IygNP/pCKQDWCgNJPCMbQ1EoVOgeiLWcGvyokMDhBtskiWyX30HzMwVjn2zYyg5PJNOHFLM88x6lYvZryr4A93JmpHkDVUqLM79Iq1etKfQC4zZxZ76fBXuiOsUmEfP/4+7FEV8=
Message-ID: <6bffcb0e0602140316sae62b9an@mail.gmail.com>
Date: Tue, 14 Feb 2006 12:16:19 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc3-mm1
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
In-Reply-To: <20060214014157.59af972f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060214014157.59af972f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/02/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3/2.6.16-rc3-mm1/
>
> - Various fixes, updates and cleanups.  Nothing very exciting, unless you
>   spend a lot of your time waiting for msync() to complete.
>
> - Again, please cast an eye across this patch series for things which should
>   go into 2.6.16.

It's strange... rc3-mm1 vs. rc2-mm1

:/usr/src/linux-mm$ uname -a
Linux ltg01-sid 2.6.16-rc2-mm1 #15 SMP PREEMPT Thu Feb 9 18:12:08 CET
2006 i686 GNU/Linux


:/usr/src/linux-mm$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 16
EXTRAVERSION =-rc3-mm1

there is something wrong with build system.

I had a lot of "modprobe: FATAL: Could not load
/lib/modules/2.6.16-rc2-mm1/ modules.dep: No such file or directory"
messages while boot.
Workaround: copy files from /lib/modules/2.6.16-rc3-mm1 to
/lib/modules/2.6.16-rc2-mm1

Regards,
Michal Piotrowski
