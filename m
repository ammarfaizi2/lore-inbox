Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWIAPyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWIAPyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWIAPyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:54:05 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:20875 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751673AbWIAPyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:54:03 -0400
Message-ID: <44F85797.9070208@drzeus.cx>
Date: Fri, 01 Sep 2006 17:53:59 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Ian Stirling <ian.stirling@mauve.plus.com>
CC: madhu chikkature <crmadhu210@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: SDIO card support in Linux
References: <f71aedf40608310804w75728559ma5fd317e16e94b56@mail.gmail.com> <44F73E37.6030602@drzeus.cx> <44F85646.4030100@mauve.plus.com>
In-Reply-To: <44F85646.4030100@mauve.plus.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Stirling wrote:
>>
>> SD mandates a star topology (just a single card per bus), so we'll just
>> force a single card into the list. SD memory cards can actually work on
>> a shared bus, SDIO can not. It's not a big problem in practice though.
>
> Is this true in SD-1 bit mode, or SPI?

Yes, no. :)

> I see nothing on a quick read-through of the abbreviated SDIO spec
> precluding  this.
> Of course, it'd mean wire-or'd interrupt lines.
>

The problem is that there is no "king-of-the-hill" mechanism in the SDIO
init sequence (like there is in SD mem). The protocol assumes that the
desired card always receives the command.

Rgds
Pierre

