Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966312AbWKTSGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966312AbWKTSGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966310AbWKTSGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:06:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40624 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966312AbWKTSGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:06:05 -0500
Message-ID: <4561EE88.6050304@redhat.com>
Date: Mon, 20 Nov 2006 13:06:00 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061105)
MIME-Version: 1.0
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFSROOT with NFS Version 3
References: <20061117164021.03b2cc24.Christoph.Pleger@uni-dortmund.de>	<1163780417.5709.34.camel@lade.trondhjem.org>	<20061120120750.1b1688e8.Christoph.Pleger@uni-dortmund.de>	<20061120135716.GA14122@tsunami.ccur.com> <20061120173311.154e54a6.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20061120173311.154e54a6.Christoph.Pleger@uni-dortmund.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Pleger wrote:
> Hello,
>
> On Mon, 20 Nov 2006 08:57:16 -0500
> Joe Korty <joe.korty@ccur.com> wrote:
>
>   
>> On Mon, Nov 20, 2006 at 12:07:50PM +0100, Christoph Pleger wrote:
>>     
>>> Warning: Unable to open an initial console
>>>       
>> This usually means /dev/console doesn't exist.  With many of
>> today's distributions, this means you didn't boot with a
>> initrd properly set up to run with your newly built kernel.
>>     
>
> The device /dev/console exists, but init/main.c tries to open it
> read-write. As the nfsroot is mounted read-only, /dev/console cannot be
> opened read-write.

If so, that is a bug.  Whether or not the file system containing the
device node is mounted read-only should not affect how a device can
be opened.

       ps
