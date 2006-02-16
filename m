Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWBPQQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWBPQQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWBPQQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:16:32 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:39020 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932316AbWBPQQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:16:31 -0500
Message-ID: <43F4A51F.1000308@cfl.rr.com>
Date: Thu, 16 Feb 2006 11:15:27 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Seewer Philippe <philippe.seewer@bfh.ch>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com>  <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com>  <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com>  <43F2E8BA.90001@bfh.ch>  <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <43F49D16.6060801@bfh.ch>
In-Reply-To: <43F49D16.6060801@bfh.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2006 16:17:26.0366 (UTC) FILETIME=[79DF07E0:01C63314]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14271.000
X-TM-AS-Result: No--0.200000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seewer Philippe wrote:
> The problem does not end with fdisk. There are tons of tools (sfdisk,
> parted, dosemu, ...) which would be affected.

I think that the important thing to remember is that these tools are 
already broken; they just don't know it.  It is better to tell the tools 
you don't know the geometry than to make something up which won't work 
for its intended purpose.


In some cases the tools still require this information but don't really 
need it at all ( like dosemu ) so they really need to be fixed.  It is 
silly to require a lie that you don't even use.

