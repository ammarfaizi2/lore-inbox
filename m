Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWH1K4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWH1K4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWH1K4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:56:18 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:46555 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964793AbWH1K4R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:56:17 -0400
Message-ID: <44F2CB09.2010809@aitel.hist.no>
Date: Mon, 28 Aug 2006 12:52:57 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
       linux-tiny@selenic.com, devel@laptop.org
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
References: <1156429585.3012.58.camel@pmac.infradead.org>	 <1156433068.3012.115.camel@pmac.infradead.org>	 <200608251611.50616.rob@landley.net> <1156538115.3038.6.camel@pmac.infradead.org>
In-Reply-To: <1156538115.3038.6.camel@pmac.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Fri, 2006-08-25 at 16:11 -0400, Rob Landley wrote:
>   
>> BusyBox has been doing this for months now: "build at once" is one of our 
>> config options.  I'd like to point out that gcc eats needs several hundred 
>> megabytes of ram to do this and you have no useful progress indicator between 
>> starting and ending.  But the result is definitely smaller.
>>     
>
> It isn't that bad when you're only building a few files at a time -- I
> wouldn't suggest doing it for the whole kernel.
>   
I suggest a new makefile target for this.

I.e. "make bzImage" as always for those who do development and
recompile after small changes/patches. 

And a "make optImage" (optimized image) when building a
kernel for production use, when you believe compiling every file
and spending lots of extra time is worth it.

Helge Hafting
