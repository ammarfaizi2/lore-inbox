Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbTF3IsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 04:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbTF3IsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 04:48:07 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:14351 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265482AbTF3IsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 04:48:05 -0400
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <200306301535.49732.kernel@kolivas.org>
References: <200306281516.12975.kernel@kolivas.org>
	 <200306291132.49068.kernel@kolivas.org>
	 <200306291457.40524.kernel@kolivas.org>
	 <200306301535.49732.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1056963742.598.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 30 Jun 2003 11:02:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-30 at 07:35, Con Kolivas wrote:

> A patch to reduce audio skipping and X jerking under load.

Can't make XMMS skip audio with "while true; do a = 2; done" while
playing moving windows under an X session.

> It's looking seriously like I'm talking to myelf here, but just in case there 
> are lurkers testing this patch, there's a big bug that made it think jiffy 
> wraparound was occurring so interactive tasks weren't receiving the boost 
> they deserved. Here is a patch with the fix in. 

Well, you're not talking to yourself. We're listening and testing:
2.5.73-mm2 + patch-O1int + patch-granularity + patch-1000HZ. With this
new version of the patch, the mouse cursor jumpiness has returned again,
altough in much less extent than in previous versions: it's more
difficult to reproduce, but it's present just when logging onto my KDE
session on a Red Hat Linux 9 box. For the rest of the session, it's
pretty hard difficult to make the mouse cursor to turn jumpy.

> How to use if you're still thinking of testing:
> Use with Hz 1000, and use the granularity patch I posted as well for smoothing 
> X off. 

Under heavy load (3 simulatenous consoles doing while true; do a=2;
done), X feels smooth, but moving windows aggresively, makes X go jerky
for a few seconds and some process do starve a little when repainting.

Anyways, at a first glance, it looks really good :-)

