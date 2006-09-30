Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWI3Wp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWI3Wp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWI3Wp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:45:57 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:51752 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751515AbWI3Wp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:45:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dHn51HEJw47J7qb/n9SgoyB6381bYYKBj8kW1LRQeZgp7Bxfn9sfIt//cvevXCKUYTEOzSORycmITB+InogikcCpOLbA1hda0mQKV4RCN6M+sXS4xvyt91IqLCKvibZuBspwTwnzG7n+EYmMjWxSaQ608aamGLkcvyXMr1SXMoc=
Message-ID: <653402b90609301545y2d4f162dq824ac360149fc0a7@mail.gmail.com>
Date: Sat, 30 Sep 2006 22:45:56 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 2.6.18 V6] drivers: add lcd display support
Cc: "Stefan Richter" <stefanr@s5r6.in-berlin.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060930144830.eba63268.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060930132253.8ccaa0ad.maxextreme@gmail.com>
	 <20060930123547.d055383f.rdunlap@xenotime.net>
	 <451EE36C.5080002@s5r6.in-berlin.de>
	 <20060930144830.eba63268.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy, I'm testing right now the V7 of the driver after fixing all
your mistakes found. Thank you for your deep work: the sharing of the
buffer was a very good point. Finally I allocated both 2 (the bigger
and the smaller one at the initialization).

In a few minutes I will send the V7 patch.

About "lcdisplay":

On 9/30/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Sat, 30 Sep 2006 23:36:44 +0200 Stefan Richter wrote:
>
> > ...
> > >> patching file drivers/lcddisplay/cfag12864b.c
> > ...
> >
> > What does the D in LCD stand for? I suggest this is named
> > drivers/lcdisplay/ instead.
>
> Yes, someone else mentioned that too.
> It does mean Display.
> not a big deal to me in this age of acronyms.
>

Well, I can rename it, but there is a problem:

How should I write the name in other places?

I mean, for example, in Kconfig:

	tristate "KS0108 LCD Controller"

if the ks0108 is a LCD controller, then

	tristate "CFAG12864B LCD Display"

should be the right way to write it?

	tristate "CFAG12864B LCDisplay"

seems so ugly to me. Is it? Remember, this applies for all the other
places in the documentation / source code / ...

IMHO it seems better as LCD Display. Yeah, drivers/lcdisplay/ would be
nice, but I don't think the same about other places:

LCD Controller.
LCDisplay??
