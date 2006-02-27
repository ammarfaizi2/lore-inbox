Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWB0Mz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWB0Mz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWB0Mz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:55:58 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:51107 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751087AbWB0Mz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:55:58 -0500
Message-ID: <4402F6E7.3050500@dgreaves.com>
Date: Mon, 27 Feb 2006 12:56:07 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gcoady@gmail.com
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
References: <200602261721.17373.jesper.juhl@gmail.com> <336402hq8014pc1cg8169f8tumhj302vho@4ax.com>
In-Reply-To: <336402hq8014pc1cg8169f8tumhj302vho@4ax.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:

>On Sun, 26 Feb 2006 17:21:17 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>  
>
>>Hi everyone,
>>
>>I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)
>>
>>	95 kernels were build with 'make randconfig'.
>>    
>>
>>That was an interresting experience. 
>>    
>>
>
>Welcome to the club ;)  I gave up make randconfig months ago as 
>there's simply too much noise in there...  There are same errors 
>popping up for months now without resolution, and I lack experience 
>to fix most things I see -- asked akpm once but not grok Andrew's 
>response (months ago).
>  
>
How about introducing an 'overlay' config that is introduced after
randconfig runs?

That gives you the ability to, for example, always set

CONFIG_EMBEDDED=n

Then you can progressivley eliminate some known issues (which is not
what you're trying to find anyway).

David

-- 

