Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTFDSLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTFDSLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:11:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:43675 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263765AbTFDSLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:11:21 -0400
Message-Id: <200306041824.h54IOY3h117032@westrelay04.boulder.ibm.com>
From: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.5.70_btime-fix_A0
To: jw schultz <jw@pegasys.ws>, lkml <linux-kernel@vger.kernel.org>
Mail-Copies-To: johnstul@us.ibm.com
Date: Wed, 04 Jun 2003 11:20:12 -0700
References: <1054681259.32091.783.camel@w-jstultz2.beaverton.ibm.com> <20030604022512.GI12649@pegasys.ws>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> On Tue, Jun 03, 2003 at 04:00:59PM -0700, john stultz wrote:
>> Since jiffies didn't necessarily start incrementing at a second
>> boundary, jiffies/HZ doesn't increment at the same moment as
>> xtime.tv_sec. This causes one second wobbles in the calculation of btime
>> (xtime.tv_sec - jiffies/HZ).
>
> Might it not be cheaper to start jiffies at the 1 second
> boundary or with a value that simulates that?

Ehhh... Mucking with the meaning of jiffies (# of timer ticks) just to fix a
math error in /proc/stat seems like a bit much. 

But I'll look to see if I can improve the math some. 

thanks
-john


