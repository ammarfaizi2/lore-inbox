Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVCMBqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVCMBqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 20:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVCMBqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 20:46:25 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:64145 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262002AbVCMBqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 20:46:22 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	<20050313004902.GD3163@waste.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I have no actual hairline...
Date: Sun, 13 Mar 2005 02:46:14 +0100
In-Reply-To: <20050313004902.GD3163@waste.org> (Matt Mackall's message of
 "Sat, 12 Mar 2005 16:49:02 -0800")
Message-ID: <je3bv0qpw9.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> On Fri, Mar 11, 2005 at 05:24:15PM -0800, john stultz wrote:
>> +struct timesource_t timesource_jiffies = {
>> +	.name = "jiffies",
>> +	.priority = 0, /* lowest priority*/
>> +	.type = TIMESOURCE_FUNCTION,
>> +	.read_fnct = jiffies_read,
>> +	.mask = (cycle_t)~0,
>
> Not sure this is right. The type of 0 is 'int' and the ~ will happen
> before the cast to a potentially longer type.

If you want an all-one value for any unsigned type then (type)-1 is the
most reliable way.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
