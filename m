Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751913AbWJIWwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWJIWwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 18:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWJIWwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 18:52:54 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:23793 "EHLO
	pne-smtpout3-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751911AbWJIWwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 18:52:53 -0400
Message-ID: <452AD2B5.3040507@gmail.com>
Date: Tue, 10 Oct 2006 01:52:37 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Liyu <raise.sail@gmail.com>
CC: greg <greg@kroah.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] usb/hid: The HID Simple Driver	Interface
 0.3.2 (core)
References: <200609291624123283320@gmail.com>		<20060929095913.f1b6f79d.rdunlap@xenotime.net>	<d120d5000609291035q7dad5f7fqcb38d4d8b3b211e5@mail.gmail.com>	<45286B85.90402@gmail.com> <452948AD.8030600@gmail.com> <4529C38A.2000708@gmail.com>
In-Reply-To: <4529C38A.2000708@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Liyu wrote:
> Anssi Hannula wrote:
>> One possibility is to do that with symbol_request() and friends. That
>> would not be pretty though, imho.
>>
>> DVB subsystem uses that currently to load frontend modules dynamically,
>> see dvb_attach() and dvb_frontend_detach() in
>> drivers/media/dvb/dvb-core/dvbdev.h and
>> drivers/media/dvb/dvb-core/dvb_frontend.c.
>>
>>   
> This means also can load module dynamically. In apparently, I think it
> have two weaknesses:
>    
>     1. It require module have one exported symbol at least.

True.

>     2. We must handle life cycle of module by myself.

We need to handle reference count, yes.

> Is it right?
> 
> Goodluck
> 
> -Liyu
> 


-- 
Anssi Hannula

