Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVAPDSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVAPDSR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 22:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVAPDSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 22:18:17 -0500
Received: from terminus.zytor.com ([209.128.68.124]:34205 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262412AbVAPDSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 22:18:15 -0500
Message-ID: <41E9DCF6.6080008@zytor.com>
Date: Sat, 15 Jan 2005 19:18:14 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: short read from /dev/urandom
References: <41E7509E.4030802@redhat.com> <20050114191056.GB17481@thunk.org> <41E833F4.8090800@redhat.com> <20050114232154.GB18479@thunk.org> <cs9vk8$43q$1@terminus.zytor.com> <20050116025159.GB3867@waste.org>
In-Reply-To: <20050116025159.GB3867@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> 
> What about signals to a process blocked on /dev/random (which also has no
> documented mention of being interruptible by signals)?
> 
> Not handling short reads is always a bug.
> 

Agreed it is.  All I was saying was that I could see a *small* exception 
(like PIPE_BUF) for /dev/urandom.

Sleeping would be utterly unacceptable.

	-hpa
