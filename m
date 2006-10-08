Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWJHVg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWJHVg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWJHVg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:36:27 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:24375 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751488AbWJHVg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:36:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JGELQezwSTfgK2WbQUlc1Wicxtfuai7BRq4podO+3CjKC479kzsm8aJQqlqtVHqyiKiub4pix/v5+cGS4S+Iu0f4byeh55cDY5Fn+IkZJ4yAx1bUpKwLCFzVLUV8VdjCS0Dd+6QixKXs3zXOe/SuCW1/4kJQKvHkxN+FIOJd9+o=
Message-ID: <653402b90610081436w34d692ecv2dd9801c451ab490@mail.gmail.com>
Date: Sun, 8 Oct 2006 23:36:26 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH 2.6.19-rc1 V9] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061008211550.GE4152@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061006002950.49b25189.maxextreme@gmail.com>
	 <20061008182438.GA4033@ucw.cz>
	 <653402b90610081137g7885fc85h54e5e94de682a246@mail.gmail.com>
	 <20061008191217.GA3788@elf.ucw.cz>
	 <653402b90610081312m32fcf7ecx9929ae9dc4768c17@mail.gmail.com>
	 <20061008211550.GE4152@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/06, Pavel Machek <pavel@ucw.cz> wrote:
>
> Yep... but when we have /dev/fbcfag12864b ... do we need
> /dev/cfag12864bX ? I think it is useless at that point.
>

Well, because cfag12864b is the generic one I think it should be in
the /dev directory (whatever if you use or don't it / whatever if it
is useless or not).

>
> /dev/fbcfag12864b is very easy to "manipulate by hand" too.
>

Yep, IMO we should add a Kconfig option instead of mixing both by
default (cfag12864b and fbcfag12864b); anyway I think having
cfag12864b & fbcfag12864b is better than mixing it all in one module.

It is a good idea that adds many advantages; althought I don't know if
other people will agree with adding it. I have no problem coding the
fbcfag12864b module in my free time; but I prefer to remain the other
modules as they are now and add the fbcfag12864b later in time: I'm
waiting them to get into one of the -rcs without more radical changes.
