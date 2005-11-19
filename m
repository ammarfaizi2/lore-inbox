Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVKSTQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVKSTQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 14:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVKSTQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 14:16:07 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:64228 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750763AbVKSTQG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 14:16:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F62H9vVbF/wyJf6gG1XQKkYlV55iLmgLWRpDJ8kcn1ZidWfIPCmohE5wCAlccV2mzscZ78JDiY9JvvZtkiDjTe9pzroG2mcmdm22aejL8cxZd6IWgaTrunO7Fks5PXG/fbogM2MxwvZNizYlgUxCcSf6KLPEQmzSgryailLMkmU=
Message-ID: <58cb370e0511191116r7196828bu3790113f38f6c8ad@mail.gmail.com>
Date: Sat, 19 Nov 2005 20:16:04 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Larry.Finger@lwfinger.net" <Larry.Finger@att.net>
Subject: Re: DMA mode locked off when via82cxxx ide driver built as module in 2.6.14
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <111920051859.9281.437F7619000700AC0000244121603763169D0A09020700D2979D9D0E04@att.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <111920051859.9281.437F7619000700AC0000244121603763169D0A09020700D2979D9D0E04@att.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Larry.Finger@lwfinger.net <Larry.Finger@att.net> wrote:
> My HP ze1115 notebook uses the via82cxxx ide driver. If I configure the kernel
> build to make that driver as a module, the driver is correctly added to initrd
> and is loaded at boot time; > however, DMA mode is turned off. It cannot be
> turned on even if I use an 'hdparm -d1 /dev/hda' command.
>
> Is this a bug, or do I need some kind of IDE=XXX boot command?
> As expected, system > performance in this mode is horrible.

You've probably left generic IDE support (CONFIG_IDE_GENERIC=y) compiled-in.

You need to disabled it in order to use via82cxxx as module.

Bartlomiej
