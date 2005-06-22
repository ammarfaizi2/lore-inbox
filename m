Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVFVLrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVFVLrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 07:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVFVLrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 07:47:25 -0400
Received: from [195.23.16.24] ([195.23.16.24]:42657 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261195AbVFVLrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 07:47:04 -0400
Message-ID: <42B94FB2.60104@grupopie.com>
Date: Wed, 22 Jun 2005 12:46:58 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more signed char cleanups in scripts
References: <20050619233029.45dd66b8.akpm@osdl.org>	<1119391748l.25237l.3l@werewolf.able.es>	<20050621151806.07ef0f78.akpm@osdl.org> <1119394780l.25237l.4l@werewolf.able.es>
In-Reply-To: <1119394780l.25237l.4l@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 06.22, Andrew Morton wrote:
>>[...]
>>I see no particular problem using uchar in the kallsyms code - I often
>>prefer it, because you can just look at the code and not have to worry
>>about nasty sign-extension problems.
> 
> Forget the part for kallsyms. After my change, it just coredumps.
> The original gcc warnings are below. The problem is using str---
> on data that are not strictly strings, but arrays of bytes...
> Each symbol struct has a field. 'sym', that stores a 'type'
> in sym[0] and a name from sym[1] to the end. A strange hacky mix.

Tell me about it :)

I'll look at the warnings and try to clean them up myself, if that's ok 
with you, since I'm in the middle of changing that code anyway.

The reason for the unsigned nature of those tokens is that after 
compression they really do hold "binary data" and not "text", so I 
wanted to keep that clear by using unsigned chars.

Anyway, thanks for the gcc4.0 output. Since I don't have a gcc4.0 
installed yet, I can use it to fix these issues and post a patch ASAP.

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
