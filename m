Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267465AbUHaInX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267465AbUHaInX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUHaInX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:43:23 -0400
Received: from jam.pd.astro.it ([193.206.241.196]:62403 "EHLO jam.pd.astro.it")
	by vger.kernel.org with ESMTP id S267465AbUHaInV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:43:21 -0400
From: Francesco Biscani <biscani@pd.astro.it>
To: reiserfs-list@namesys.com, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: System freeze: __iounmap: bad address dfd00000
Date: Tue, 31 Aug 2004 10:40:40 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <1093735779.41311563b892b@webmail.pd.astro.it> <9e473391040830181941d62ed0@mail.gmail.com>
In-Reply-To: <9e473391040830181941d62ed0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408311040.40444.biscani@pd.astro.it>
X-OAPD-MailScanner-Information: 
X-OAPD-MailScanner: Found to be clean
X-OAPD-MailScanner-SpamCheck: non spam, SpamAssassin (punteggio=-104.9,
	necessario 6, autolearn=not spam, BAYES_00, USER_IN_WHITELIST)
X-MailScanner-From: biscani@pd.astro.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 August 2004 03:19, Jon Smirl wrote:
> On Sun, 29 Aug 2004 01:29:39 +0200, biscani@pd.astro.it
>
> <biscani@pd.astro.it> wrote:
> > Aug 28 18:43:00 kurtz __iounmap: bad address dfd00000
>
> That address looks like it might be a video card. cat /proc/iomem or
> lspci -v will tell you the owner and give you a clue where to look for
> problems.

I had come to the same conclusion. I upgraded to the latest drm kernel drivers 
(DRI cvs) and the message disappeared. It was a mistake to associate it with 
IO-activity. Shame on me.

On the other side, I'm using kernel -ck5, which includes reiser4 and does not 
suffer from the problem I described. I'm waiting for the next -mm release to 
see if it gets fixed there too.

BTW, thanks to all you people at xorg, you are doing a wonderful job :-)

Regards,

-- 
Dr. Francesco Biscani

Dipartimento di Astronomia
Università di Padova

biscani@pd.astro.it
