Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVBHUL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVBHUL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVBHUK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:10:28 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:9452 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261655AbVBHUKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:10:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GEn5Li56ymWKkBk6+fhEl5eckVx4Ri5gBObe/50oGVpPwwNnYNJSjnwrE7Pl3Oe4bZDyGXPxZvQk+m7EUMGMY4aW5R3RL3Mr7NXiph0J2cnvx4CQafU21kxtwEbNWmOSNWZUjO0lNU2kXf57dHd6whYFhuri+TJxOV9EG1xDE/E=
Message-ID: <8a8a2c8205020812094ea28421@mail.gmail.com>
Date: Tue, 8 Feb 2005 12:09:57 -0800
From: Alex Muradin <amuradin@gmail.com>
Reply-To: Alex Muradin <amuradin@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ARM undefined symbols. Again.
In-Reply-To: <20050208194243.GA8505@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124154326.A5541@flint.arm.linux.org.uk>
	 <20050131161753.GA15674@mars.ravnborg.org>
	 <20050207114359.A32277@flint.arm.linux.org.uk>
	 <20050208194243.GA8505@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting your mail!

Check out you code cause if I'm getting your mail, then you're sending
it out to all your customers.

-Alex
amuradin@gmail.com

Gmail user


On Tue, 8 Feb 2005 20:42:43 +0100, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Mon, Feb 07, 2005 at 11:43:59AM +0000, Russell King wrote:
> >
> > Maybe we need an architecture hook or something for post-processing
> > vmlinux?
> Makes sense.
> For now arm can provide an arm specific cmd_vmlinux__ like um does.
> 
> The ?= used in Makefile snippet below allows an ARCH to override the
> definition of quiet_cmd_vmlinux__ and cmd_vmlinux__
> 
> quiet_cmd_vmlinux__ ?= LD      $@
>      cmd_vmlinux__ ?= $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) -o $@ \
>      -T $(vmlinux-lds) $(vmlinux-init)                          \
>      --start-group $(vmlinux-main) --end-group                  \
>      $(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) FORCE ,$^)
> 
>        Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
