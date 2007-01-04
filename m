Return-Path: <linux-kernel-owner+w=401wt.eu-S964849AbXADNvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbXADNvg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbXADNvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:51:36 -0500
Received: from mail.atmel.fr ([81.80.104.162]:57109 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964849AbXADNvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:51:35 -0500
Message-ID: <459D05EC.9010907@rfo.atmel.com>
Date: Thu, 04 Jan 2007 14:49:32 +0100
From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Organization: atmel
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Dmitry Torokhov <dtor@insightbb.com>, Imre Deak <imre.deak@solidboot.com>,
       linux-kernel@vger.kernel.org, tony@atomide.com
Subject: Re: [patch 2.6.20-rc1 6/6] input: ads7846 directly senses PENUP state
References: <20061222192536.A206A1F0CDB@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200612281437.56888.david-b@pacbell.net>	
	 <200612290122.52752.dtor@insightbb.com> <200612291226.46984.david-b@pacbell.net>
In-Reply-To: <200612291226.46984.david-b@pacbell.net>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 8bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell a écrit :
> On Thursday 28 December 2006 10:22 pm, Dmitry Torokhov wrote:
>> I appied all patches except for hwmon as it had some issues with CONFIG_HWMON
>> handling. Could you please take a look at the patch below and tell me if it
>> works for you?
> 
> Looked OK, except:
> 
>> +#if defined(CONFIG_HWMON) || (defined(MODULE) && defined(CONFIG_HWMON_MODULE))
> 
> That idiom is more usually written
> 
> 	#if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
> 
> Thanks!  I'll be glad to see fewer versions of this driver floating around.
> And to see the next version of the ads7843 patches ... :) 

Hi, I am back on this task... I hope I will have a working patchset soon.

I face an issue using the hrtimer instead of the old timer framework 
(your patch #4/6). It seems that I do not sample at a sufficient rate 
using hrtimer : I see squares when drawing circles ;-)

Do you know if the hrtimer framework has an issue on at91 or do I have 
to code something to have a low res timer support in the hrtimer framework ?

Cheers,
-- 
Nicolas Ferre


