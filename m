Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUCPSYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUCPSYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:24:11 -0500
Received: from web80508.mail.yahoo.com ([66.218.79.78]:15990 "HELO
	web80508.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261159AbUCPSYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:24:10 -0500
Message-ID: <20040316182409.54329.qmail@web80508.mail.yahoo.com>
Date: Tue, 16 Mar 2004 10:24:09 -0800 (PST)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
To: Vojtech Pavlik <vojtech@suze.cz>, torvalds@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> +	
> +	/* Workaround for broken chips which seem to
support MUX, but in reality don't. */
> +	/* They all report version 12.10 */
> +	if (mux_version == 0xCA)
> +		return -1;

Hi, 

I think it should be 0xAC (0xA4 with 4th bit flipped)
as the version reported is 10.12:

i8042.c: Detected active multiplexing controller, rev
10.12.

>From little debug info that I've been sent ThinkPad's
controllers seem to be flipping 4th bit sometimes, I
can't quite pinpoint the exact sequence.

Dmitry

P.S. Sorry for breaking the threading...
