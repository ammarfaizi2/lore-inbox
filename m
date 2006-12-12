Return-Path: <linux-kernel-owner+w=401wt.eu-S1751481AbWLLPyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWLLPyr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 10:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWLLPyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 10:54:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:7428 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbWLLPyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 10:54:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H7GDw+6YuQoTLnB43RKOOXM1rc917uBxx817lhNgjgxY7X/19NIiyyzt7jXF5WkdL/kf6NhQ+7AFRkkFy+bHYssIsVUz2Bpo/ovZx/+j1/p/DQxiLcAI3qw5vgbFANYAQOle9Z3Hsp+yXKZt9/XaSPvtLFWTrwP7S/kRz3nOVDs=
Message-ID: <d120d5000612120754n1cb71fc3m61032fdafd1f24d5@mail.gmail.com>
Date: Tue, 12 Dec 2006 10:54:42 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Florian Festi" <ffesti@redhat.com>
Subject: Re: [PATCH] input: Extend raw mode to work up to keycode 0xFF
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <457D9D14.5090006@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457D9D14.5090006@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/06, Florian Festi <ffesti@redhat.com> wrote:
> Hi, [please CC me, as I am not subscribed]
>
> currently keycodes above 240 are ignored if the tty is in raw mode. To make the key codes from 241 to 255 usable for programs in raw mode (like X11) the still unused scancodes were
> added into that range. Right know these scancodes are used in arbitrary order due the lack of a better alternative. Comments on a better way of using them are welcome.
>
> This extension is needed for some keycodes I submited in a previous patch.
>

Values equal or greater 0xf0 (240) have special meaning in PS/2
protocol (aka rawmode) and therefore shall not be used for
transmitting keycodes. It looksl ike we have 0x1a0 range open
(although you will have to use evdev driver to get these keycodes,
which is not a bad thing).

-- 
Dmitry
