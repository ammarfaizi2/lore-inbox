Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVG1VOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVG1VOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVG1VOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:14:00 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:19354 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262331AbVG1VNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:13:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=BSfWJjdyPqaB7j3nenBNrHWjXGRqv1qK2sa+ORmOB6KnQef1HHqFLkPOO3dSovb+TV2xE8BU2jn9e4kc7V08FWw521rokew6233+xcC7W06OorGKxNE5J97hQ9GO/AvWCHjSkXTRmBoGLsqScrcxLuPh6iw/xBQiWLBb08uT2ow=
Message-ID: <42E96738.4090800@gmail.com>
Date: Thu, 28 Jul 2005 23:16:08 +0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050726)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Nick Sillik <n.sillik@temple.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org>	<42E957B5.8040606@gmail.com> <20050728131525.31fa8640.akpm@osdl.org> <42E94679.2020009@temple.edu>
In-Reply-To: <42E94679.2020009@temple.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Sillik schrieb:

> Andrew Morton wrote:
>
>> Michael Thonke <iogl64nx@gmail.com> wrote:
>>
>>> Hello Andrew,
>>>
>>> I have some questions :-)
>>> Reiser4:
>>>
>>> why there are undefined functions implemented that currently not in 
>>> use?
>>> This messages appeared first time in 2.6.13-rc3-mm2.
>>>
>>> Any why it complains even CONFIG_REISER4_DEBUG is not set?
>>
>>
>>
>> That's due to the code using `#if CONFIG_xx' instead of `#ifdef'.
>>
>
> I previously posted a patch that got rid of one of these, find it 
> attached again below.
>
> Signed-off-by: Nick Sillik <n.sillik@temple.edu>
>
>------------------------------------------------------------------------
>
>diff -urN a/fs/reiser4/plugin/node/node40.h b/fs/reiser4/plugin/node/node40.h
>--- a/fs/reiser4/plugin/node/node40.h	2005-07-27 18:14:04.000000000 -0400
>+++ b/fs/reiser4/plugin/node/node40.h	2005-07-27 18:14:53.000000000 -0400
>@@ -80,7 +80,7 @@
> int check_node40(const znode * node, __u32 flags, const char **error);
> int parse_node40(znode * node);
> int init_node40(znode * node);
>-#if GUESS_EXISTS
>+#ifdef GUESS_EXISTS
> int guess_node40(const znode * node);
> #endif
> void change_item_size_node40(coord_t * coord, int by);
>  
>
Thanks, this fixed the complains on compiling kernel :-)

