Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbTLWDi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 22:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTLWDi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 22:38:27 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:17530 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264922AbTLWDi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 22:38:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Thomas Molina <tmolina@cablespeed.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: synaptics mouse jitter in 2.6.0
Date: Mon, 22 Dec 2003 22:38:17 -0500
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.58.0312222127530.18261@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0312222127530.18261@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312222238.17076.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 December 2003 09:40 pm, Thomas Molina wrote:
> I am running Fedora Core 1 updated on a Presario 12XL325 laptop.  For a
> long time during the 2.5 series I couldn't use the synaptics support. 
> As a result, I haven't tested this for some time.  I just compiled a
> fresh 2.6.0 tree, included synaptics support and now I am getting mouse
> jitter.
>
> The easiest way to see this is to open Mozilla and go to a page with a
> lot of text links such as a news site with links to a number of
> stories. With synaptics support compiled in I get side to side jitter
> when moving the mouse over a link.  It looks as if my finger has a
> nervous twitch in it.  Then, when I take my finger off the touchpad to
> click on the link, the mouse cursor jumps about an eighth of an inch in
> a random direction.  It is very annoying since the jump takes it off
> the link and I can't click on it.
>
> Compiling synaptics support out gets me back to a stable mouse cursor.

Right, I think I see it. The mousedev module does not do any smoothing
of the reported coordinates which would cause the jitter you are seeing.
Normally drivers do 3- or 4-point average.

I'll cook up something to fix it. Meanwhile could you give a try Peter
Osterlund XFree86 Synaptics driver:
http://w1.894.telia.com/~u89404340/touchpad/index.html

Dmitry
