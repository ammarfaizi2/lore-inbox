Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751715AbWGZRRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWGZRRF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWGZRRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:17:04 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:60662 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751715AbWGZRRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:17:02 -0400
Date: Wed, 26 Jul 2006 10:11:39 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew de Quincey <adq_dvb@lidskialf.net>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
In-Reply-To: <20060726150041.GG23701@stusta.de>
Message-ID: <Pine.LNX.4.63.0607261008240.10256@qynat.qvtvafvgr.pbz>
References: <20060725034247.GA5837@kroah.com>  <200607261510.03098.adq_dvb@lidskialf.net>
  <20060726142932.GE23701@stusta.de>  <200607261539.50492.adq_dvb@lidskialf.net>
 <20060726150041.GG23701@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Adrian Bunk wrote:

> On Wed, Jul 26, 2006 at 03:39:49PM +0100, Andrew de Quincey wrote:
>> On Wednesday 26 July 2006 15:29, Adrian Bunk wrote:
>> ...
>>> The real problem is:
>>> How do we get some testing coverage of -stable kernels by users to catch
>>> issues?
>>> And compile errors are the least of my worries.
>>
>> Yeah - I believe some people did test the DVB -stable patches, but obviously
>> without the budget-av driver compile option enabled, so it didn't compile
>> that code. DVB supports quite a few cards, so its easy to accidentally leave
>> off one of the options when doing a mass compile of all drivers.
>>
>> The only thing I can think of would be to require -stable patch submitters to
>> supply a list of CONFIG options that must be on to enable compilation of the
>> new code so people know exactly how to enable it for testing... but obviously
>> since those would be manually specified, they can be wrong too. But at least
>> it would show they'd thought about it a bit....
>
> This helps only with compilation errors, which are as I said the least
> of my worries.

however, this can be automaticly tested (or at least the config options 
specified can be tested)

> But does the hardware driven by this driver work?
> And if it does, is there a bug in the patch that causes the kernel to
> crash after some hours?

this cannot be tested by anyone who doesn't use the driver in question, and 
frequently that includes the programmer who makes the changes.

there's no way to protect against a logic error in a driver, however it is 
possible to put a safety net in place to catch compile problems due to mistakes.

should such a net be put into place? (along with asking submitters what compile 
options are relavent to their code), or is this a mistake that is rare enough to 
just live with it when it happens?

David Lang
