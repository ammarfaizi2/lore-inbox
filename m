Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVLJOtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVLJOtb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 09:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVLJOtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 09:49:31 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:21914 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932420AbVLJOtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 09:49:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Device files for keyboard(s)?
Date: Sat, 10 Dec 2005 09:49:28 -0500
User-Agent: KMail/1.9
References: <20051210085752.GF15679@schottelius.org>
In-Reply-To: <20051210085752.GF15679@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512100949.29185.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 December 2005 03:57, Nico Schottelius wrote:
> Hello dear Kernel-Developers,
> 
> I've the problem that I've connected two keyboards
> (one via usb and one via ps/2) to my machine and I want to have
> different keyboard layout on it.
> 
> While I was trying to find out what would be the best way to do that,
> I was somehow surprised that keyboards are not presented via
> a device file to userspace.
>

They are. You need to use event input interface. All input devices can
be accessed via /dev/input/eventX device nodes.
 
> My questions are:
> 
> - Is there a reason not to have devices for keyboards?
> - If I would implement it into a recent kernel, would it have any chance
>   getting into mainline?
> 
> I know this would have some consequences for user space, at least those:
> 
> - x11 (x.org/xfree) would have to modify their input device section for Linux
>   for keyboards
> - loadkeys would have to be patched so one could specify which keyboard
>   to change the layout for
> - kde/gnome would have to be changed in the manner that they support more
>   than one keyboard
> 
> Nico
> 
> P.S.: Please cc me.
> 

-- 
Dmitry
