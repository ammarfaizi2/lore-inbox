Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268160AbUHKSYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbUHKSYs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268154AbUHKSYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:24:48 -0400
Received: from [195.23.16.24] ([195.23.16.24]:21641 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268160AbUHKSYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:24:44 -0400
Message-ID: <411A646A.5040702@grupopie.com>
Date: Wed, 11 Aug 2004 19:24:42 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lei Yang <leiyang@nec-labs.com>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compression algorithm in cloop
References: <411A4D34.6000104@lougher.demon.co.uk> <411A5E55.3050508@nec-labs.com>
In-Reply-To: <411A5E55.3050508@nec-labs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.6; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lei Yang wrote:
> 
> If I don't want to build a new compression library and port it to 
> kernel, all I want to do is to try out the idea -- whether it could work 
> on cloop, whether the compression ratio is acceptable, can I just change 
> the cloop code? In other words, I just need a loopback block device with 
> other compression scheme.

If you just want to try out some wacky ideas, I suggest you take a look 
at the network block device.

It is a block device that sends all read/write requests through a socket 
  so that this requests can be fulfilled by a user space deamon.

This is not very good in terms of performance, but it is much easier to 
develop this kind of thing in userspace, without all the stack / memory 
/ atomicity / concurrency problems :)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"
