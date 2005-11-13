Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVKMXgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVKMXgM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 18:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVKMXgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 18:36:12 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:52215 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750784AbVKMXgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 18:36:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=D7cFIwOiiS17uu2D/ABv8AAP7qUaaGLhImLMap8IOjDxP2814KEIwmKfar1HtJ3sQARaLtLMMF/wtoIYJ8AL4mp4TPmgbLStI0LQqu1FcGA0QIvNUWS2yHpsqRwMrXpSuXCsoRoiIh3D67zQswWb0tDOspZoZqGHuWeUWNxVp6s=
Message-ID: <4377CDD8.1000509@gmail.com>
Date: Mon, 14 Nov 2005 07:35:52 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
CC: 7eggert@gmx.de, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Jason <dravet@hotmail.com>,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
References: <58c2Z-8jG-23@gated-at.bofh.it> <E1EbNir-0006ky-DP@be1.lrz> <4377BA19.2060600@gmail.com> <4377BD8A.9070404@kolumbus.fi>
In-Reply-To: <4377BD8A.9070404@kolumbus.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Penttilä wrote:
> Antonino A. Daplas wrote:
> 
>> Bodo Eggert wrote:
>>  
>>
>>> Antonino A. Daplas <adaplas@gmail.com> wrote:
>>>
>>>   
>>>> +++ b/drivers/video/console/vgacon.c
>>>> +#define VGA_FONTWIDTH       8   /* VGA does not support fontwidths
>>>> != 8 */
>>>>     
>>> This is not true, VGA cards do support fontwidth=9, but the ninth column
>>>   
>>
>> Yes.  What it should mean is that vgacon does not support fontwidths
>> != 8.
>>
>>  
>>
> I think vgacon doesn't touch the 8/9 pixel setting, so  the fonts are hw
> extended to 9 pixels by VGA in many modes.
> 

It's not a hardware limitation, but vgacon is hardcoded to accept fonts that are
only 8 pixels wide.  You can try it by doing a setfont.

Tony
