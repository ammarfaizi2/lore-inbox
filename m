Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVACVlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVACVlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVACVlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:41:47 -0500
Received: from terminus.zytor.com ([209.128.68.124]:27037 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261409AbVACVli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:41:38 -0500
Message-ID: <41D9BC07.8070209@zytor.com>
Date: Mon, 03 Jan 2005 13:41:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
References: <20050103172013.GA29332@holomorphy.com> <41D9881B.4020000@pobox.com> <20050103180915.GK29332@holomorphy.com> <Pine.LNX.4.61.0501031329030.13385@chaos.analogic.com> <crccas$la0$1@terminus.zytor.com> <20050103213627.GS29332@holomorphy.com>
In-Reply-To: <20050103213627.GS29332@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Mon, Jan 03, 2005 at 09:09:48PM +0000, H. Peter Anvin wrote:
> 
>>Dear Wrongbot,
>>Bullshit.  Signed is promoted to unsigned.
> 
> I'm not sure who you're responding to here, but gcc emitted an actual
> warning and I was only attempting to carry out the minimal effort
> necessary to silence it. I'm not really interested in creating or
> being involved with controversy, just silencing the core build in the
> least invasive and so on way possible, leaving deeper drivers/ issues
> to the resolution of the true underlying problems.
> 
> I don't have anything to do with the code excerpt above; I merely
> followed the style of the other unsigned integer coercions in the file.
> 

I was not responding to you, your stuff is perfectly sane.

The claim from the Wrongbot was that "foo + 1" is bad when foo is a 
size_t.  This is utter bullshit, since that's EXACTLY equivalent to:

	foo + (size_t)1

... because of promotion rules.

	-hpa
