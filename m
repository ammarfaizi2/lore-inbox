Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWB1Fjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWB1Fjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 00:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWB1Fjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 00:39:36 -0500
Received: from relay4.usu.ru ([194.226.235.39]:20946 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750863AbWB1Fjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 00:39:35 -0500
Message-ID: <4403CAE9.5020007@ums.usu.ru>
Date: Tue, 28 Feb 2006 09:00:41 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Memory compression (again). . help?
References: <4403A14D.4050303@comcast.net>
In-Reply-To: <4403A14D.4050303@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.1.0; VDF: 6.33.1.33; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I'm not quite sure what I'm doing or when I have time, but I'm looking
> into writing in some hooks and a compression routine to manage
> compressed memory.  I have the following considerations:
> 
>  - Compressed memory should become "Swap."  This means the kernel would
>    report memory used for compressed storage as used swap.  At boot it
>    would reflect 0K swap; when there are 1024KiB of pages compressed in
>    memory, 1024KiB of additional "swap" is reported, all used.
>  - I need to stop the kernel when it's about to swap.  This should be
>    done when it's decided that either invalidating disk cache or
>    swapping is the best course of action, and what to do with what.  At
>    this point I'll have to be able to see what the kernel wants to swap
>    out and tell it that it's taken care of.
>  - I need to catch invalid pagefaults that look for swap, as well as the
>    disk cache mechanism.  I'll be adding stuff to compress disk cache,
>    so disk cache might need to be "swapped in" effectively.

If you are OK with using a ery old 2.4.18 kernel, look at 
http://linuxcompressed.sourceforge.net/

-- 
Alexander E. Patrakov
