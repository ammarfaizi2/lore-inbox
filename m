Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTAIKjc>; Thu, 9 Jan 2003 05:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbTAIKjc>; Thu, 9 Jan 2003 05:39:32 -0500
Received: from lakemtao01.cox.net ([68.1.17.244]:58589 "EHLO
	lakemtao01.cox.net") by vger.kernel.org with ESMTP
	id <S265197AbTAIKjb>; Thu, 9 Jan 2003 05:39:31 -0500
Message-ID: <3E1D5343.9040404@cox.net>
Date: Thu, 09 Jan 2003 04:47:31 -0600
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Niels den Otter <Niels.denOtter@surfnet.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.55: local symbols in net/ipv6/af_inet6.o
References: <20030109091025.GW31387@surly.surfnet.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niels den Otter wrote:
> As of 2.5.54bk6 (including 2.5.55) I get the following compilation error:
> 
SNIP!
> net/built-in.o(.init.text+0x1a34): In function `inet6_init':
> : undefined reference to `local symbols in discarded section .exit.text'
> make: *** [vmlinux] Error 1
> 
> 
> The reference_discarded.pl script says following:
>  pangsit:/usr/src/linux/net> perl ~otter/reference_discarded.pl 
>  Finding objects, 245 objects, ignoring 0 module(s)
>  Finding conglomerates, ignoring 11 conglomerate(s)
>  Scanning objects
>  Error: ./ipv6/af_inet6.o .init.text refers to 000003e4 R_386_PC32 .exit.text
>  Done
> 
> I tried both gcc-2.95 & gcc-3.2.2 .

Change the IPv6 option in your config from Y to M. That is a workaround 
until whoever fixes that. I get it too.

-David

