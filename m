Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTLTDtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 22:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbTLTDtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 22:49:52 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:6004 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263800AbTLTDtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 22:49:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: psmouse synchronization loss under load
Date: Fri, 19 Dec 2003 22:49:44 -0500
User-Agent: KMail/1.5.4
References: <20031220015131.GB9834@vitelus.com>
In-Reply-To: <20031220015131.GB9834@vitelus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312192249.44633.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 December 2003 08:51 pm, Aaron Lehmann wrote:
> On a Dell laptop whenever I run a program that takes the full CPU, my
> mouse pointer goes insane and thrashes my X session every few minutes.
> It seems to have a mind of its own and always be able to make it to
> the Exit item in the root menu ;). Whenever this happens, psmouse logs
> and detects the error:
>
> psmouse.c: Mouse at isa0060/serio4/input0 lost synchronization,
> throwing 2 bytes away.
>

That means that mouse interrupt hasn't been serviced for more than 0.5
seconds. You could try commenting out that piece of code in
drivers/input/mouse/psmouse-base.c but I think that's a sign that something
else is going on in the kernel - 0.5 sec is pretty long.

Dmitry
