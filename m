Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVKKAcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVKKAcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVKKAcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:32:31 -0500
Received: from spectre.fbab.net ([212.214.165.139]:14748 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S932123AbVKKAcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:32:31 -0500
Message-ID: <4373E69B.6040206@fbab.net>
Date: Fri, 11 Nov 2005 01:32:27 +0100
From: "Magnus Naeslund(f)" <mag@fbab.net>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Claudio Scordino <cloud.of.andor@gmail.com>
CC: "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: [PATCH] getrusage sucks
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <200511110123.29664.cloud.of.andor@gmail.com>
In-Reply-To: <200511110123.29664.cloud.of.andor@gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Scordino wrote:
> On Friday 11 November 2005 00:47, Hua Zhong (hzhong) wrote:
>
>>The reason is what if tsk is no longer available when you call
>>getrusage?
>
>
> Sorry, but honestly I don't see any problem: as you can see from my
patch, if
> tsk is no longer available, getrusage returns -1 and sets errno
appropriately
> (equal to EINVAL, which means that who is invalid).
>
>             Claudio
>

You need to wrap this with a read_lock(&tasklist_lock) to be safe, I think.

Regards,
Magnus
