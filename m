Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTGGWfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 18:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTGGWfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 18:35:22 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:55449 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262227AbTGGWfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 18:35:19 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: [PATCH] Synaptics: support for pass-through port (stick)
Date: Mon, 7 Jul 2003 17:51:35 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <Pine.LNX.4.40.0307072020380.3501-100000@shannon.math.ku.dk>
In-Reply-To: <Pine.LNX.4.40.0307072020380.3501-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307071751.35221.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 July 2003 01:35 pm, Peter Berg Larsen wrote:
>
> A complete different problem that might be a problem is that even though
> the master(pad) says it has passthough capabilities, there might not be
> any guest attached. The bit only tells that it is capable of handling one.
> I asked synaptics about this some time ago and they replyed that the only
> way to find out is to send a byte and look for a returnbyte or a timeout.

I think this won't be a problem - if there is no guest attached then, when
we register pass-through serio port, psmouse_probe will run. The very first
thing it to tries identify attached device and bails out if something
goes wrong. In our case it should time out. This will leave us with a serio
without input device attached - a perfectly valid scenario I think.

Dmitry


