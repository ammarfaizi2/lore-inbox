Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUBWWsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUBWWsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:48:35 -0500
Received: from mail.convergence.de ([212.84.236.4]:50561 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262063AbUBWWsM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:48:12 -0500
Message-ID: <403A831B.7040307@convergence.de>
Date: Mon, 23 Feb 2004 23:47:55 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Michael Hunold <hunold@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] tda1004x DVB frontend update
References: <10775702831806@convergence.de> <10775702843054@convergence.de> <20040223211844.A14186@infradead.org>
In-Reply-To: <20040223211844.A14186@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/04 22:18, Christoph Hellwig wrote:
>> #ifndef DVB_TDA1004X_FIRMWARE_FILE
>>-#define DVB_TDA1004X_FIRMWARE_FILE "/usr/lib/hotplug/firmware/tda1004x.mc"
>>+#define DVB_TDA1004X_FIRMWARE_FILE "/usr/lib/hotplug/firmware/tda1004x.bin"
>> #endif

> Why would the kernel driver want to know the exact path of the firmware file?

Because we don't use the in-kernel firmware loader at the moment.

The driver comes from a time were 2.4 didn't have the firmware loader 
and drivers cloned the firmware loading stuff from one of the soundcard 
drivers.

Currently there is no way to solve this problem, because we don't have 
any kernel structure that we could attach to and have it export the 
sysfs and firmware loading magic.

We plan to use the kernel i2c subsystem again, then all our problems 
hopefully vanish.

CU
Michael.
