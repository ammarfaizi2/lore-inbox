Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSLPWOx>; Mon, 16 Dec 2002 17:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSLPWOx>; Mon, 16 Dec 2002 17:14:53 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:17027 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261723AbSLPWOw>;
	Mon, 16 Dec 2002 17:14:52 -0500
Date: Mon, 16 Dec 2002 23:18:58 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212162218.XAA01969@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.21-pre1 broke the ide-tape driver
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Dec 2002 14:53:33 +0000, Alan Cox wrote:
>On Sun, 2002-12-15 at 23:38, Mikael Pettersson wrote:
>> 
>> On Sun, 15 Dec 2002 02:23:34 +0100, Marc-Christian Petersen wrote:
>> >> Kernel 2.4.21-pre1 broke the ide-tape driver: the driver
>> >> now hangs during initialisation. 2.2 kernels (with Andre's
>> >> IDE patch) and 2.4 up to 2.4.20 do not have this problem.
>> >> My box has a Seagate STT8000A ATAPI tape drive as hdd;
>> >> hdc is a Philips CD-RW, and the controller is ICH2 (i850 chipset).
>> >http://linux.bkbits.net:8080/linux-2.4/patch@1.828?nav=index.html|ChangeSet@-7d|cset@1.828
>> 
>> Addendum: this patch fixes the init-time hang, and ide-tape does
>> seem to work fine, but 'rmmod ide-tape' oopses -- 2.4.20-ac2 also
>> oopses on 'rmmod ide-tape'.
>
>I don't unfortunately have any ide-tape devices. I'll take a look though

I can trigger the oops by a simple 'modprobe ide-tape; rmmod ide-tape'
even on boxes without ide-tape devices.
