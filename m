Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWHZThz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWHZThz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 15:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWHZThz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 15:37:55 -0400
Received: from ptb-relay03.plus.net ([212.159.14.214]:55509 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S1750734AbWHZThz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 15:37:55 -0400
Message-ID: <44F0A310.4010107@mauve.plus.com>
Date: Sat, 26 Aug 2006 20:37:52 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux@horizon.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial custom speed deprecated?
References: <20060826181639.6545.qmail@science.horizon.com>
In-Reply-To: <20060826181639.6545.qmail@science.horizon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
>> Or we could just add a standardised extra set of speed ioctls, but then
>> we need to decide what occurs if I set the speed and then issue a
>> termios call - does it override or not.
> 
<snip>
> Alternatively, you could observe that asynchronous communications only
> requires agreement withing 5% between sender and receiver, so specifying
> a baud rate to much better than 1% is not too important.

To nitpick.
For a 10 bit long word, if the receiver syncs to within 1/8th of  the 
middle of a bit-time at the start, you've got 2/8th of a bit-time of 
disagreement possible, before you are likely to get errors, especially 
on limited slew-rate signals. (more modern chips will likely sample faster)
Or 3/80, or 2.5%. If the other side has made a similar calculation, then 
you should only really rely on 1%.
5% is the best possible case - that will in most circumstances cause errors.
