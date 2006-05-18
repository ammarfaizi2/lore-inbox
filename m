Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWEREKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWEREKH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWEREKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:10:07 -0400
Received: from mail.aknet.ru ([82.179.72.26]:24079 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751148AbWEREKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:10:05 -0400
Message-ID: <446BF398.80507@aknet.ru>
Date: Thu, 18 May 2006 08:10:00 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] add input_enable_device()
References: <20060517194757.6566.qmail@web81101.mail.mud.yahoo.com>
In-Reply-To: <20060517194757.6566.qmail@web81101.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
>> Why does it have the INPUT_DEVICE_ID_MATCH_BUS after all?
> For userspace benefits.
How exactly does the userspace benefit from the
INPUT_DEVICE_ID_MATCH_BUS thing?
And, by the way, why doesn't the input have the
capability of disabling/enabling the device?

> While you are fine with
> disabling beeps while music is playing otherpeoplr might still want
> to hear them.
The only possibility to do this, was to have the grabbing
capability *in input layer*, which you already rejected too.
With this, it was possible to have such a behaviour run-time
configurable, but now my best bet would be to resort to the
Kconfig games, making a note for users that the uinput is now
an only possibility to route the terminal beeps to the snd-pcsp.

