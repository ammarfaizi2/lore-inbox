Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVC3MGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVC3MGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 07:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVC3MGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 07:06:44 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:60124 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261853AbVC3MGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 07:06:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LKZmqrx4xXotT5xYGDdRnzXyueeL7TfOE+7d+v5aoXbsP8RINBf9B1TsqBHQkIRC9Knq7ELQQYYjfeBpvNzs1i7EuAdrZHLEN6z12gqmz3tV4E43d3Iy9QISaCq6HkHA0Tx2BpF/9p+LGo3S3zpCMMZTpkdubimGS4VZIIXO3zY=
Message-ID: <58cb370e05033004065b14da51@mail.gmail.com>
Date: Wed, 30 Mar 2005 14:06:37 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: kus Kusche Klaus <kus@keba.com>
Subject: Re: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231C2@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <AAD6DA242BC63C488511C611BD51F3673231C2@MAILIT.keba.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005 13:52:05 +0200, kus Kusche Klaus <kus@keba.com> wrote:

> However, things break seriously when exercising the CF card in parallel
> (e.g. with a dd if=/dev/hda of=/dev/null):
> 
> * The rtc *interrupt handler* is delayed for up to 250 *micro*seconds.
> This is very bad for my purpose, but easy to explain: It is roughly the
> time needed to transfer 512 Bytes from a CF card which can transfer 2
> Mbyte/sec, and obviously, the CPU blocks all interrupts while making pio
> 
> transfers. (Why? Is this really necessary?)
>  
> (I know because I instrumented the rtc irq handler with rdtscl(), too)

hdparm -u1 /dev/hda

should help
