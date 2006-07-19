Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWGSPtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWGSPtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWGSPtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:49:08 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:7586 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1030191AbWGSPtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:49:07 -0400
Message-ID: <44BE545D.2050403@cmu.edu>
Date: Wed, 19 Jul 2006 11:48:45 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Jeff Chua <jchua@fedex.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <200607190005.02351.rjw@sisk.pl> <44BE4FB7.5050108@cmu.edu> <200607191742.32609.rjw@sisk.pl>
In-Reply-To: <200607191742.32609.rjw@sisk.pl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rafael,

it's resuming now after a suspend to disk.  However it seems to have the
same problem as my suspend to memory.

No matter which I do, after the computer resumes, it works until a disk
access happens.  For instance, if i suspend to disk while in X, then
resume, i get my windows back and everything, however the minute I open
up a console and type "ls", things start to bomb and lock up... i never
get a response from the ls command

The same thing goes for suspending to memory.  I have "AHCI" mode set in
the bios, i know someone mentioned switching to compatability mode, but
from what I understand, some have gotten it to work in AHCI mode?

Thanks!
George


Rafael J. Wysocki wrote:
> On Wednesday 19 July 2006 17:28, George Nychis wrote:
>> Oh, and what should the default resume partition be (for
>> CONFIG_SOFTWARE_SUSPEND)? my root partition?
> 
> No, your swap partition, but you don't need to set it.
> 
> It can also be passed to the kernel with the resume= command line argument.
> 
> 
>> Rafael J. Wysocki wrote:
>>> On Tuesday 18 July 2006 17:26, George Nychis wrote:
>>>> acpid has been started, however there is no /sys/power/disk
>>> Have you set CONFIG_SOFTWARE_SUSPEND in .config?
>>>
>>> Rafael
>>>
> 
