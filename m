Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbUAESSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUAESSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:18:46 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:38823 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265289AbUAESRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:17:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse info in 2.6.1-rc1
Date: Mon, 5 Jan 2004 13:17:23 -0500
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.58.0401051711170.23750@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.58.0401051711170.23750@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401051317.23795.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 January 2004 12:16 pm, Marcos D. Marado Torres wrote:
> Hi there...
> I don't really know if this is only in -rc1-mm1 but I suppose -rc1 is
> affected also.
>
> The new changes in drivers/input/mouse/psmouse-base.c make that we
> don't have anymore to give to kernel  psmouse_proto=imps, but only
> proto=imps , so the info about it is wrong... Please apply the patch:
>
> --- linux-2.6.1-rc1-mm2/drivers/input/mouse/Kconfig     2004-01-05
> 10:51:16.000000000 +0100 +++
> linux-2.6.1-rc1-mm2-mbn1/drivers/input/mouse/Kconfig        2004-01-05
> 13:34:26.000000000 +0100 @@ -30,7 +30,7 @@
>                 http://www.geocities.com/dt_or/gpm/gpm.html
>           to take advantage of the advanced features of the touchpad.
>           If you do not want install specialized drivers but want
> tapping -         working please use option psmouse.proto=imps.
> +         working please use option proto=imps.
>
>           If unsure, say Y.


It is psmouse.proto=imps if psmouse is built in the kernel and proto=imps
if psmouse is compiled as a module. I mentioned only the first form because
I assumed that most people have it built-in.

Generally with the module_param macros kernel parameters have a prefix
in form of "module_name." if module is built into the kernel.

Dmitry
