Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVA2Xyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVA2Xyc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVA2Xyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:54:32 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:35952 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261609AbVA2Xya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:54:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Q6Gu3/aV1txtA0aEg421AWmteTJfNgH92JIKGnwVFYPok7YudU24yUEtEywdVoP9cehC2OcuiQ0BVtkB387+v2WLPXVOg5PSyxpc7b2rsFBbo8HO5jk+4iU7XJ1lFf7/frcxIGyZJRQjBEmHxuFzx+w1Yl71x9Jvfy5+OrAumqw=
Message-ID: <58cb370e0501291554450fbef8@mail.gmail.com>
Date: Sun, 30 Jan 2005 00:54:30 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/cdrom/isp16.c: small cleanups
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050129234624.GC3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050129171108.GB28047@stusta.de>
	 <58cb370e05012909513cc96b17@mail.gmail.com>
	 <20050129234624.GC3185@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005 00:46:24 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Sat, Jan 29, 2005 at 06:51:25PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > On Sat, 29 Jan 2005 18:11:08 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > > This patch makes the needlessly global function isp16_init static.
> > >
> > > As a result, it turned out that both this function and some other code
> > > are only required #ifdef MODULE.
> >
> > Your patch is correct but it is wrong. ;)
> >
> > #ifdefs around isp16_init() need to be removed as
> > otherwise this driver is not initialized in built-in case.
> 
> It's somehow initialized via isp16_setup.

Could you explain?

AFAICS isp16_setup() only handles "isp16=" boot parameter.
