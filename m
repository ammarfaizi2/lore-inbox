Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318383AbSGYI1l>; Thu, 25 Jul 2002 04:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318384AbSGYI1l>; Thu, 25 Jul 2002 04:27:41 -0400
Received: from [195.63.194.11] ([195.63.194.11]:64517 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318383AbSGYI1k>; Thu, 25 Jul 2002 04:27:40 -0400
Message-ID: <3D3FB5F6.3060000@evision.ag>
Date: Thu, 25 Jul 2002 10:25:26 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Samuel Thibault <samuel.thibault@fnac.net>, martin@dalecki.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/ide/qd65xx: no cli/sti (2.4.19-pre3 & 2.5.28)
References: <Pine.LNX.4.44.0205260248160.17222-400000@youpi.residence.ens-lyon.fr> <Pine.LNX.4.10.10207250128110.4868-100000@bureau.famille.thibault.fr> <20020725093154.A21541@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, Jul 25, 2002 at 01:45:00AM +0200, Samuel Thibault wrote:
> 
>>Hello,
>>
>>Here are patches for 2.4.19-pre3 & 2.5.28 which free them from using
>>cli/sti in qd65xx stuff.
> 
> 
> Cool.
> 
> 
>>(also using ide's OUT_BYTE / IN_BYTE btw)
> 
> 
> In my opinion this doesn't make sense. The qd65xx is a VESA Local Bus
> only hardware and is very very unlikely to be used on anything else than
> an x86, where these defines are needed. Also, the ports written to are
> not a part of the IDE controller region, so the IN_BYTE/OUT_BYTE macros
> might not work there if it was ever used on a non-x86 machine. Also, it
> makes the code less readable.

Amen. BTW> I think proper fix is to simple *remove* the cli() cti()
commands. They don't make much sense in first place.

