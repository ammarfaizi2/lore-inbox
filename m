Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVBLV5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVBLV5h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 16:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVBLV5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 16:57:37 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:7330 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261205AbVBLV5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 16:57:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kuB829o4Rawb8n9pz8u0HPIHlOSnK/sWtzxF55urpa8wlKLB0wuVhi0n/z0AQ3j8TgmbxplNG3G2Uz2nFLPj0c+kyD1ksvASGVUEX8LAkf9cvXE14vJYK2MCLGulKr4R/iNPw2V0oUVbBFrwNCOZPpYwxY1n9QgOJ7NsFxV6E10=
Message-ID: <5a4c581d050212135716fa6a17@mail.gmail.com>
Date: Sat, 12 Feb 2005 22:57:34 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc3-bk9 (radeon) hangs hard my laptop
Cc: benh@kernel.crashing.org
In-Reply-To: <5a4c581d05021207593fae0c93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5a4c581d0502120649423a2504@mail.gmail.com>
	 <5a4c581d05021207593fae0c93@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Feb 2005 16:59:20 +0100, Alessandro Suardi
<alessandro.suardi@gmail.com> wrote:
> On Sat, 12 Feb 2005 15:49:05 +0100, Alessandro Suardi
> <alessandro.suardi@gmail.com> wrote:
> > Dell Latitude C640, PIV @1.8Ghz, 1GB RAM, uptodate FC2
> >
> > -bk7 (which I currently rebooted in) is okay.
> > -bk9 at first try got me to the login prompt, logged in, ran startx...
> >  frozen with the black background before seeing anything.
> >
> > Second try hung well before, at the point where it switches the
> >  radeonfb on.
> >
> > Only cure is to keep the power button pressed for 10".
> >
> > Will try building -bk8 (which is currently running on my
> >  old desktop K7-800) and report...
> 
> -bk8 which I'm now booted in is also OK, so something
>  broke between -bk8 and -bk9... attached .config and
>  /var/log/messages from the boot in -bk8 and the one
>  in -bk9 which succeeded before hanging on startx.

It's definitely the new radeon changes - replacing
 drivers/video/aty/* and include/video/radeon.h in the
 -bk9 tree with the ones from -bk8 causes the hang to
 not reproduce anymore. CC'd Ben and edited subject
 to more accurately reflect the issue.

Thanks,

--alessandro

  "There is no distance that I don't see
  I do have a will - No limit to my reach"
  
    (Wallflowers, "Empire In My Mind")
