Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbUBPX2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUBPX2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:28:45 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:29875 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266053AbUBPX2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:28:40 -0500
Message-ID: <40315225.3010104@uchicago.edu>
Date: Mon, 16 Feb 2004 17:28:37 -0600
From: Ryan Reich <ryanr@uchicago.edu>
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
References: <1pw4i-hM-27@gated-at.bofh.it> <1pw4i-hM-29@gated-at.bofh.it> <1pw4i-hM-31@gated-at.bofh.it> <1pw4i-hM-25@gated-at.bofh.it> <1pLmG-4E7-5@gated-at.bofh.it> <1pRLz-21o-33@gated-at.bofh.it> <1pRVi-2am-27@gated-at.bofh.it> <1pWi8-65a-11@gated-at.bofh.it>
In-Reply-To: <1pWi8-65a-11@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> Ryan Reich wrote:
> 
>> On Mon, 16 Feb 2004, Ryan Reich wrote:
>> 
>> Sorry, I didn't realize that your problem was also the inconsistency
>> in module names.  Someone else suggested using a shell expansion; you
>> could try
>> 
>> cat /proc/modules | tr _ - | grep -q "^${module_name/_/-}"
>> 
>> which is both short and works.
>> 
> tr is usually in /usr/bin, which might not be available at boot time.
> And probably you mean 'grep -q "^${module_name//_/-}"'
> 
> Did I mention that the inconsistency requires ugly and error- prone
> workarounds? QED

It's not THAT ugly, and it's also error-prone to type at the keyboard. The
only fundamental error in my suggestion was the location of tr.

Anyway, if you really want to correct the inconsistencies you need only
edit the sources for the modules in question; the names which appear in
/proc/modules appear to be defined in, for example,
drivers/usb/host/uhci-hcd.c, where the .description section of the module
is set. Or change the filenames, though I don't know how that will fly with
the make process.

-- 
Ryan Reich
ryanr@uchicago.edu
