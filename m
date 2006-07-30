Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWG3OsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWG3OsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWG3OsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:48:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:7748 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932323AbWG3OsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:48:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j9zJPJhpwp67Q9q6H0jd74beZPRAZwtKgAkON2Xt9EgVL+3Nk3atFIxF7nqF2srqheGiyW7bELYpRs+sV7UPGRbacarCm7q69pM4aXnin7Z73UW+bb5bbXMJBXtlp+joNj5jaa4f0w7aclXKx6rKsYj+HxPfFPUgJdYd413dQL8=
Message-ID: <41840b750607300748u23d24653s273123be5017be63@mail.gmail.com>
Date: Sun, 30 Jul 2006 17:48:22 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "kernel list" <linux-kernel@vger.kernel.org>
Subject: Re: Generic battery interface
In-Reply-To: <20060730142909.GA11854@irc.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
	 <41840b750607280819t71f55ea7off89aa917421cc33@mail.gmail.com>
	 <d120d5000607280910t458fb6e0hdb81367b888a46db@mail.gmail.com>
	 <20060730085500.GB17759@kroah.com>
	 <41840b750607300252w445974b1udedf1a67114d1580@mail.gmail.com>
	 <20060730142909.GA11854@irc.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/06, Tomasz Torcz <zdzichu@irc.pl> wrote:
> On Sun, Jul 30, 2006 at 12:52:52PM +0300, Shem Multinymous wrote:
> > Put otherwise:
> > Q:Quick, which io scheduler is used by /dev/scd0?
> > A: cat /sys/dev/$((0x`stat -c%t /dev/scd0`))/\
> >                $((0x`stat -c%T /dev/scd0`))/queue/scheduler
>
>  A2: cat /sys`udevinfo -n scd0 -q path`/queue/scheduler  ?

You win.
Since udev manages /dev, it makes sense to ask it for this info. I
guess one can think of major:minor as a udev private implementation
detail, in this context.

  Shem
