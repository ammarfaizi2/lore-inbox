Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVAOBMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVAOBMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVAOBJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:09:36 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:5400 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262078AbVAOBF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:05:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Q6m/wICnsc2AYxREhQo3vTTiUvMFzlm/BJ6p6wfGATq/uVykZatL5Lh9db3fnhJ4LzPq6Jjbxi8Nby80GlvAxZoxxq22h1oh6aTe0Tdn3m7Au+5QLvySdNGQTEai4Aca4yAj/yjwoOjsA/YjfeZSTdQuBQPTMJdTe5UAPucRplU=
Message-ID: <58cb370e05011417057bae2e@mail.gmail.com>
Date: Sat, 15 Jan 2005 02:05:27 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Gunther Mayer <gunther.mayer@gmx.net>
Subject: Re: [PATCH-2.6.10] ide-lib printk readability fix
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <41E07F55.8030803@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E07F55.8030803@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Jan 2005 16:48:21 -0800, Gunther Mayer <gunther.mayer@gmx.net> wrote:
> Hi,
> this improves logic and readability:
> - remove blank from: AbortedCommand (as other flags)
> - add blank and {} to error= line
> - clean up: remove 2 lines and extra printk
> 
> before:
>   hdd: status error: status=0x7f { DriveReady DeviceFault SeekComplete
> DataRequest CorrectedError Index Error }
>   hdd: status error: error=0x7fIllegalLengthIndication EndOfMedia
> Aborted Command MediaChangeRequested LastFailedSense 0x07
> 
> after:
>   hdd: status error: status=0x7f { DriveReady DeviceFault SeekComplete
> DataRequest CorrectedError Index Error }
>   hdd: status error: error=0x7f { IllegalLengthIndication EndOfMedia
> AbortedCommand MediaChangeRequested LastFailedSense=0x07 }
> 
> Please apply.

applied
