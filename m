Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270630AbRHNSaD>; Tue, 14 Aug 2001 14:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270643AbRHNS3y>; Tue, 14 Aug 2001 14:29:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:16351 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S270641AbRHNS3n>;
	Tue, 14 Aug 2001 14:29:43 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 14 Aug 2001 18:29:55 GMT
Message-Id: <200108141829.SAA108540@vlet.cwi.nl>
To: Gunther.Mayer@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make psaux reconnect adjustable
Cc: Andries.Brouwer@cwi.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From Gunther.Mayer@t-online.de Tue Aug 14 19:10:40 2001

    >     I can confirm what you suggest:
    >         My mouse (Logitech wheel USB/PS2) sends indeed AA 00.
    >     So, I extended my patch:
    >     psmouse_reconnect = 0: Do nothing (just pass all to userspace)
    >     psmouse_reconnect = 1: Flush Q & ping mouse on AA 00 (default)
    >     psmouse_reconnect = 2: Flush Q & ping mouse on AA (old behaviour)
    > 
    >     With reconnect 1 or 2: After reconnecting, mouse behaves strange
    >         (jumping around the screen)

    This is a serious bug in many user-space drivers. PS/2 mouse protocol
    was designed to easily re-synchronize (think about transmission errors/
    lost bytes).

The fragment of text you reply to is not about the 3-byte PS/2
protocol, but about the 4-byte wheelmouse protocol.
