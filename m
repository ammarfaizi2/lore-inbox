Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVBBBsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVBBBsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 20:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVBBBsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 20:48:37 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:41089 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S262202AbVBBBse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 20:48:34 -0500
Message-ID: <4200316C.2080709@am.sony.com>
Date: Tue, 01 Feb 2005 17:48:28 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>	 <41FFFD4F.9050900@am.sony.com>	 <1107298089.2040.184.camel@cog.beaverton.ibm.com>	 <4200166A.6050309@am.sony.com> <1107303548.2040.204.camel@cog.beaverton.ibm.com>
In-Reply-To: <1107303548.2040.204.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> Interesting patch. Indeed, the trade off is just how quickly you want to
> boot vs how much drift you gain each suspend/resume cycle. Assuming all
> of the clocks are good, your patch could introduce up to 2 seconds of
> drift each suspend/resume cycle. 

If we're not writing to the RTC on suspend, then I believe the drift is
capped.  For some consumer products, 2 seconds of drift is OK.

Nigel, does the RTC get written to, or just read, on suspend?

Also, I'm worried about the clock appearing to run backwards over a suspend.
Unless a suspend/resume cycle took less than 1 second, I don't think this could
happen.  Is that right?

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
