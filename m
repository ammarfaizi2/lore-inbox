Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWBBXLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWBBXLH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWBBXLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:11:07 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:33296 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751153AbWBBXLG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:11:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GTTX4uh4j6oTbDuMk1qcyt2Jn556x2Pu6PQbkJOm60ul7QB5oEVj1TYNjjW/3gdoOBnVSVEFv33YYvPzWTvc41+QZ+tfC5x5EPg5G95QIL203LLCImXD7j4Leb741RQSdNW+pG47l8aPnddgeNLb3b7y2k7+zDobqh6UG6E9w+A=
Message-ID: <7f45d9390602021511t108b4931kd17d3bca5eb0d5cd@mail.gmail.com>
Date: Thu, 2 Feb 2006 16:11:05 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Liyitec PS/2 touch panel driver [PATCH]
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
> What stops this driver form binding to serio ports that have devices other
> that Liyitec touchscreen connected to them? Such as keyboard port when
> keyboard works in non-translated mode or regular AUX port with standard
> PS/2 mouse? Is there a way to query for presence of the touchscreen?
>
> Moreover this driver should be integrated into psmouse so proper protocol
> is selected automatically.

I've just posted an updated version of my Liyitec driver that
incorporates the trivial changes suggested by others on this list.
This driver is quite useful in its current state, as it does allow a
Liyitec touch screen to be used, which currently has no support at
all. It does however have a few outstanding issues.

1. The Liyitec driver will grab all unclaimed PS/2 devices.
2. It does this because there is no probing and identification code.
3. This driver would probably be better off as a psmouse driver rather
than a serio driver, but this would first require the missing probe
code.

It should certainly be possible to detect the presence of a Liyitec
touch screen, but I haven't figured out how yet. Trivially, the
Liyitec touch screen appears to be a PS/2 mouse that happens to be
returning very unusual coordinates.

Cheers,
Shaun
