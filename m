Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWCXE7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWCXE7R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 23:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWCXE7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 23:59:16 -0500
Received: from mail.aknet.ru ([82.179.72.26]:8976 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751393AbWCXE7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 23:59:15 -0500
Message-ID: <44237CB2.8000400@aknet.ru>
Date: Fri, 24 Mar 2006 07:59:30 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
References: <200603220652.k2M6qZgi020656@shell0.pdx.osdl.net>	 <d120d5000603221332n6a6f9208x5651dc9ec993f4bf@mail.gmail.com>	 <4422318C.407@aknet.ru>	 <d120d5000603230651p6b43aad9ocad1aa3c2b51b388@mail.gmail.com>	 <4422E2DA.7050305@aknet.ru>	 <d120d5000603231012h1c0f5s8ecde64e67641317@mail.gmail.com>	 <4422E968.1050506@aknet.ru>	 <d120d5000603231047q6e777243nb4031b701dbdc494@mail.gmail.com>	 <4422F85E.7000200@aknet.ru> <d120d5000603231236n1294b492x93a107ce3971de5f@mail.gmail.com>
In-Reply-To: <d120d5000603231236n1294b492x93a107ce3971de5f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
>> Or, why not to have the grabbing capability in the input layer, so
>> that the driver can request an exclusive handling of some events?
> That can be explored, although does not answer how you do about
> allowing concurrent access to the hardware.
I could simply grab SND_BELL so that the pcspkr won't even receive it.

> I understand that the beeps kill music currently; they should not if
> you have lower level module controlling access.
OK, that's a driver core stuff then, you are right.
I'll see what can be done about the legacy/ISA devices there,
but from the first glance it doesn't look promising...

