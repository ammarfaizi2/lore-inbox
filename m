Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWHAVVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWHAVVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWHAVVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:21:31 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14733 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750769AbWHAVVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:21:30 -0400
Message-ID: <44CFC59A.5050609@zytor.com>
Date: Tue, 01 Aug 2006 14:20:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ricknu-0@student.ltu.se
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Nicholas Miell <nmiell@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Noschinski <cebewee@gmx.de>
Subject: Re: [PATCH 1/2] include/linux: Defining bool, false and true
References: <1154175570.44cb5252d3f09@portal.student.luth.se> <1154176331.44cb554b633ef@portal.student.luth.se> <44CFA934.9010404@zytor.com> <1154466739.44cfc3b34a222@portal.student.luth.se>
In-Reply-To: <1154466739.44cfc3b34a222@portal.student.luth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ricknu-0@student.ltu.se wrote:
> Citerar "H. Peter Anvin" <hpa@zytor.com>:
> 
>> ricknu-0@student.ltu.se wrote:
>>> This patch defines:
>>> * a generic boolean-type, named "bool"
>>> * aliases to 0 and 1, named "false" and "true"
>>>
>>> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
>> Shouldn't this simply use _Bool?
> 
> Well, it is (now) just a typedef of it. :)
> 
> But I find it better, both because it is more similar to the common types:
> short, lowlettered words. But also because most editors with highlightning
> recognize "bool", but not "_Bool", as a type (as I found it).
> 

<stdbool.h> should include:

typedef _Bool bool;
#define true  1
#define false 0

There is no enum involved.

	-hpa
