Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVG1NQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVG1NQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVG1NQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:16:51 -0400
Received: from [195.23.16.24] ([195.23.16.24]:1466 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261251AbVG1NQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:16:51 -0400
Message-ID: <42E8DAC0.9030108@grupopie.com>
Date: Thu, 28 Jul 2005 14:16:48 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, Greg KH <greg@kroah.com>,
       dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices
 from userspace
References: <20050726003018.GA24089@kroah.com>	 <20050726015401.GA25015@kroah.com>	 <9e473391050725201553f3e8be@mail.gmail.com>	 <9e47339105072719057c833e62@mail.gmail.com>	 <20050728034610.GA12123@kroah.com>	 <9e473391050727205971b0aee@mail.gmail.com>	 <20050728040544.GA12476@kroah.com>	 <9e47339105072721495d3788a8@mail.gmail.com>	 <20050728054914.GA13904@kroah.com>	 <20050728070455.GF9985@gaz.sfgoth.com> <9e47339105072805545766f97d@mail.gmail.com>
In-Reply-To: <9e47339105072805545766f97d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 7/28/05, Mitchell Blank Jr <mitch@sfgoth.com> wrote:
>>[...]
>>It looks sane-ish to me, but also more complicated than need be.  Why can't
>>you just do something like:
>>
>>        while (count > 0 && isspace(x[count - 1]))
>>                count--;
> 
> Do we need to deal with UTF8 here? I did the forward loop because you
> can't parse UTF8 backwards. If UTF8 is possible I need to change the
> pointer inc function.

I don't think it matters here. Even with UTF8, any char that makes 
isspace return true, can't be part of a multi-byte char, as every byte 
in a multi-byte char in UTF8 has the MSB set, i.e., >= 0x80.

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
