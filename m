Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUIAPhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUIAPhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUIAPhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:37:11 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:29056 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266890AbUIAPcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:32:03 -0400
Message-ID: <4135EB12.3050401@rtr.ca>
Date: Wed, 01 Sep 2004 11:30:26 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: bzolnier@milosz.na.pl, Lee Revell <rlrevell@joe-job.com>,
       Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <200408272005.08407.bzolnier@elka.pw.edu.pl> <1093630121.837.39.camel@krustophenia.net> <200408272059.51779.bzolnier@elka.pw.edu.pl> <4135CC9E.5060905@rtr.ca> <4135E017.1000901@pobox.com>
In-Reply-To: <4135E017.1000901@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >> I haven't examined the "released" IDE drivers in some time,
 >> but one optimisation that can save a LOT of CPU usage
 >> is for the driver to only use LBA48 *when necessary*,
 >> and use LBA28 I/O otherwise.
 >>
 >> Each access to an IDE register typically chews up 600+ns,
 >> or the equivalent of a couple thousand instruction executions
 >> on a modern core.  Avoiding LBA48 when it's not needed will
 >> save four such accesses per I/O, or about 2.5us.

Yup, this is for ATA register accesses, not SATA FISs.
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
