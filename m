Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVA1TeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVA1TeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVA1T26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:28:58 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:14549 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262796AbVA1T1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:27:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NveEupt4v7MTk4FoPBwYHDuWbNsEIIxVVJDm2AWPNkZPchkapO5suvrqm9CJ3uknTpQlhddBNHH3U7LAgNjqb1O2F9fSo4CMy5P4YRExoypBCSw3lDyjaTRIk42FaxrULmOMaPsl08gDTp+9CVBsTE1VLYrf7vIsxDknFzeHR4g=
Message-ID: <d120d5000501281127752561a3@mail.gmail.com>
Date: Fri, 28 Jan 2005 14:27:20 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Wiktor <victorjan@poczta.onet.pl>
Subject: Re: AT keyboard dead on 2.6
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <41FA90F8.6060302@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41F11F79.3070509@poczta.onet.pl>
	 <d120d500050121074831087013@mail.gmail.com>
	 <41F15307.4030009@poczta.onet.pl>
	 <d120d500050121113867c82596@mail.gmail.com>
	 <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz>
	 <d120d50005012806467cc5ee03@mail.gmail.com>
	 <41FA90F8.6060302@poczta.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 20:22:32 +0100, Wiktor <victorjan@poczta.onet.pl> wrote:
> Hi,
> 
> >This dmesg looks like the keyboard works perfectly OK. Do new lines
> >appear in dmesg when you press keys while the system is running?
> 
> eeeeeeee.....no? no, they don't. i've new dmesg for you - it reports
> timeouts while trying to perform keyboard reset (by atkbd.reset=1).
> after detection pressing any keys has absolutley no effect. maybe it's
> some timeout-violation?
> 

Could you please try editing drivers/input/serio/i8042.c and add
udelay(20) before and after calls to i8042_write_data() in
i8042_kbd_write() and i8042_command().

-- 
Dmitry
