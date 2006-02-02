Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWBBBAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWBBBAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWBBBAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:00:23 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:43653 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161017AbWBBBAW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:00:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZXW1Iu0CLkSwIo3M9YIe0v0cR02sHh5OScIIIiMIYXVhgRS90OLfUc9A8Adazz/jcyYtjFv3eAGSdSszsK05hCaUfLUQsj1jl2lqnGK6bkm9YRJmdGGhB35wGK5fu2ZQc/B6AfM4DUz18pG6fmLyf5JFNpKKim67RN60+effztI=
Message-ID: <7f45d9390602011700u702c5f4du5afdadc1e958a62e@mail.gmail.com>
Date: Wed, 1 Feb 2006 18:00:22 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Liyitec PS/2 touch panel driver [PATCH]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200601312320.05143.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390601311459o45de3c34sd4d25fc7990c728d@mail.gmail.com>
	 <200601312320.05143.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> Hi Shaun,
>
> Thank you for adding support for the new touchscreen, however I have a
> couple of questions:
>
> What stops this driver form binding to serio ports that have devices other
> that Liyitec touchscreen connected to them? Such as keyboard port when
> keyboard works in non-translated mode or regular AUX port with standard
> PS/2 mouse?

Nothing is preventing it from seizing other PS/2 ports, as far as I
know. I believe it's working for me right now because the keyboard
grabs the keyboard PS/2 port first, and then the liyitec driver grabs
the rest of the ports, which, in my case, is only the psaux port which
is connected to the liyitec screen.

> Is there a way to query for presence of the touchscreen?

I'm not sure. I'll find out what the touchscreen's response to the
PS/2 GETID command is.

> Moreover this driver should be integrated into psmouse so proper protocol
> is selected automatically.

In a private mail to me, Vojtech Pavlik pointed out that lifebook.c is
a PS/2 touch screen that does exactly this, and in only 136 lines of
code. I'll see if I can adapt my existing serio driver to be a psmouse
driver.

Thanks for your comments, Dmitry. Cheers,
Shaun
