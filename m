Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVAISbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVAISbh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 13:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVAISbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 13:31:37 -0500
Received: from hermes.domdv.de ([193.102.202.1]:15121 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261692AbVAISbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 13:31:25 -0500
Message-ID: <41E17860.1040100@domdv.de>
Date: Sun, 09 Jan 2005 19:30:56 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Notify user of MCE events (updated)
References: <Pine.LNX.4.61.0501082121380.13639@montezuma.fsmlabs.com>	<m1sm5av9fd.fsf@muc.de>	<Pine.LNX.4.61.0501091005590.13639@montezuma.fsmlabs.com> <m1fz1av5am.fsf@muc.de>
In-Reply-To: <m1fz1av5am.fsf@muc.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:
> 
>>+	 */
>>+	if (notify_user && console_logged) {
>>+		notify_user = 0;
>>+		clear_bit(0, &console_logged);
>>+		printk(KERN_EMERG "Machine check exception logged\n");
> 
> 
> Another suggestion: don't make this KERN_EMERG. Make it KERN_INFO. 
> Logged errors are usually correct, so there is no need for an 
> emergency.

Just asking:
How about KERN_NOTICE? KERN_INFO is in my opinion too easily lost in the 
syslog noise. Personally I'm logging KERN_INFO just to console, 
KERN_NOTICE however to file.
An MCE event would suit the description "normal but significant 
condition" of KERN_NOTICE as far as I can see.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
