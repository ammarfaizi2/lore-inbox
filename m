Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbTGDH1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 03:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbTGDH1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 03:27:20 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:60683 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265826AbTGDH1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 03:27:17 -0400
Message-ID: <3F052F3B.8090603@prim-time.fr>
Date: Fri, 04 Jul 2003 09:39:39 +0200
From: Aurelien Minet <a.minet@prim-time.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030521 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Dagfinn_Ilmari_Manns=E5ker?= <ilmari@ilmari.org>
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] rfcomm oops in 2.5.74
References: <d8jznjvzr07.fsf@wirth.ping.uio.no>	<3F04458C.4070502@prim-time.fr> <d8jptkrzjvh.fsf@wirth.ping.uio.no>
In-Reply-To: <d8jptkrzjvh.fsf@wirth.ping.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dagfinn


> I noticed it when rfcomm(1) segfaulted and caused the oops on startup,
> so I straced it. The strace output is:
> 
>   [linking stuff snipped]
>   socket(0x1f /* PF_??? */, SOCK_RAW, 3 <unfinished ...>
>   +++ killed by SIGSEGV +++
> 
> According to <net/bluetooth/bluetooth.h> 0x1f is PF_BLUETOOTH and 3 is
> PTPROTO_RFCOMM. Looking at the source, rfcomm(1) uses SOCK_RAW for the
> RFCOMM control socket (for ioctls: RFCOMMGETDEVLIST, RFCOMMCREATEDEV,
> RFCOMMRELEASEDEV, RFCOMMGETDEVINFO), and SOCK_STREAM for the data
> sockets.
> 
> What is the correct way of doing these ioctls on 2.5 if not against a
> SOCK_RAW socket?
Yes, the use of iotcl need SOCK_RAW socket. But I am not aware about 
iotcl with RFCOMM (just whit HCI) and even less under 2.5 .
But I saw in 2.4 that it is for the TTY RFCOMM module, I think it should 
only  be used in this module.
If it is while your are using TTY over bluetooth, ask Marcel and Max on 
Bluez List they can help you much more than me.

Sorry for the lack of help


Aurelien




