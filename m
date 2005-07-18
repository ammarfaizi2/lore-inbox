Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVGRL5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVGRL5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVGRL5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:57:14 -0400
Received: from [195.23.16.24] ([195.23.16.24]:1192 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261609AbVGRL5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:57:13 -0400
Message-ID: <42DB9911.9010106@grupopie.com>
Date: Mon, 18 Jul 2005 12:57:05 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hiroyuki Machida <machida@sm.sony.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] FAT robustness
References: <42D9FDAC.3010109@sm.sony.co.jp>
In-Reply-To: <42D9FDAC.3010109@sm.sony.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiroyuki Machida wrote:
> [...]
>  Q3 : I'm not sure JBD can be used for FAT improvements.       Do you 
> have any comments ?

I might not be the best person to answer this, but this just seems so 
obvious:

If you plan to let a recently hot-unplugged device to be used in another 
OS that doesn't understand your journaling extensions, your disk will be 
corrupted.

If this is supposed to work only on OS's that understand your journaling 
extensions, then there are much better filesystems out there with 
journaling already.

You might be able to reduce the size of the time window where hot 
removing the media will cause problems, like writting all the data first 
and update the metadata in as few operations as possible. But that just 
reduces the probability of data corruption. It doesn't eliminate it at all.

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
