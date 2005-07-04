Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVGDWgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVGDWgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 18:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVGDWgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 18:36:16 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:32178 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261705AbVGDWgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 18:36:11 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ALPS psmouse_reset on reconnect confusing Tecra M2
Date: Mon, 4 Jul 2005 17:05:17 -0500
User-Agent: KMail/1.8.1
Cc: Mike Waychison <mike@waychison.com>, Dmitry Torokhov <dtor@mail.ru>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
References: <42C9A69A.5050905@waychison.com>
In-Reply-To: <42C9A69A.5050905@waychison.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507041705.17626.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 July 2005 16:14, Mike Waychison wrote:
> Hi,
> 
> I just upgrade my Tecra M2 this weekend to the latest GIT tree and
> noticed that my mouse pointer/touchpad is now broken on resume.
> 
> Investigating, it appears that mouse device gets confused due to the
> introduced psmouse_reset(psmouse) during reconnect:
>
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f3a5c73d5ecb40909db662c4d2ace497b25c5940

Hi,

Please try the following patch:

	http://www.ucw.cz/~vojtech/input/alps-suspend-typo
 
> Are you sure that the psmouse_reset is really the right thing to do?

Yes, it helps on some other laptops.

-- 
Dmitry
