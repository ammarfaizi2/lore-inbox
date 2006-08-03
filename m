Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWHCQKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWHCQKP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWHCQKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:10:14 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:7572 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932579AbWHCQKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:10:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=apD8DPUR8wNzgVt4mFtH0DhO2i4GpL4t/9pQEI65MPJNlssw8Evba0f+IDJ40OgZ9JALAGNbP4Fk9/eXFTm8ZDJELyXSYtZh/3RGu26n9aRGeqFwDLLWDKl02gAosA1eptC6VHqbcSU4pMnbWKzRjq75Ppvcxvz1ROTBkL2avwA=
Message-ID: <44D21FDA.4090303@gmail.com>
Date: Thu, 03 Aug 2006 20:10:02 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, mchehab@infradead.org,
       v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
       b.buschinski@web.de
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] DVB_CORE must select I2C
References: <20060727015639.9c89db57.akpm@osdl.org> <20060803155925.GA25692@stusta.de>
In-Reply-To: <20060803155925.GA25692@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Jul 27, 2006 at 01:56:39AM -0700, Andrew Morton wrote:
>> ...
>> Changes since 2.6.18-rc2-mm1:
>> ...
>> +dvb-core-needs-i2c.patch
>> ...
>>  DVB fixes
>> ...
> 
> This means people who observed a compile error will now have the DVB 
> support silently removed from their kernel.
> 
> Please replace it with the patch below.


DVB_CORE should never depend on I2C, the reason being DVB_CORE does not
use anything of I2C but, the drivers which depend on I2C should be made
depend on I2C. That would be the right way to go.


Manu
