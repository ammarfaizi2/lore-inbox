Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbTEAOt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbTEAOt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:49:28 -0400
Received: from mbox2.netikka.net ([213.250.81.203]:12012 "EHLO
	mbox2.netikka.net") by vger.kernel.org with ESMTP id S261355AbTEAOtY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:49:24 -0400
From: Thomas Backlund <tmb@iki.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Date: Thu, 1 May 2003 18:01:38 +0300
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EB0413D.2050200@superonline.com> <b8r26l$he0$1@main.gmane.org> <1051790876.21546.10.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051790876.21546.10.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305011801.39014.tmb@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viestissä Torstai 1. Toukokuuta 2003 15:07, Alan Cox kirjoitti:
> On Iau, 2003-05-01 at 13:00, Thomas Backlund wrote:
> > but there are programs that benefits from the "extra" memory...
> > this according to Antonino Daplas...
> > (AFAIK double/triple buffering is one thing...)
>
> I've actually looke through the traces  for some situations
> and the "how much memory" case is reporting banked RAM on some
> cards so you don't know that RAM exists.
>
> The change proposed is definitely correct for the default. Whether
> you want to support overriding it I don't know - I'm not worried
> either way.

You mean the patch that only looks at videomode, dont you...

Well maybe it's best to use it as default, to avoid this bug 
"out of the box"...

But I will remake a patch to ovverride it so that the users who 
need/want the extra memory to be able to allocate it...
since I like the idea of giving the user the choice...

The next thing that comes to mind is of course that
it need to be done so that you can't kill the system with the
vram setting... but that should not be to hard...

Thomas

-- 
Thomas Backlund

tmb@iki.fi
www.iki.fi/tmb

