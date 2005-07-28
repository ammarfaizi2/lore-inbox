Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVG1UYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVG1UYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVG1UWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:22:19 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:54905 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261726AbVG1UVU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:21:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uTAAAOZRxFXPjVbfomH/5FhNhy1qjDuvimwyUX2ndoqm8xzNHs2wIT2W47Ad1tLZG+SDFR2ct0oFmDmBcBJJgf6k1n+lk9RzMvUO92I1nyUxGA2+NZCGV0qn6LlZwxQ6VSKn64tR7Ap6HuxprZ/9rhYfQitUtM1xhYkpSJC8hmQ=
Message-ID: <9e47339105072813213db7cee4@mail.gmail.com>
Date: Thu, 28 Jul 2005 16:21:19 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910507281315419c3c12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
	 <9e473391050728060741040424@mail.gmail.com>
	 <42E8F0CD.6070500@gmail.com>
	 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
	 <9e473391050728092936794718@mail.gmail.com>
	 <9e47339105072811183ac0f008@mail.gmail.com>
	 <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be>
	 <9e4733910507281315419c3c12@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 28 Jul 2005, Jon Smirl wrote:
> > > I can't see a way to query how long of cmap the device supports using
> > > the current fbdev ioctls.
> >
> > Look at the lengths of the color bitfields?
> 
> Which color bitfields? Does hardware that supports 10bit cmap also
> support a 10:10:10 framebuffer? If you can't do 10:10:10 how do the
> 10bit cmaps work?  Does alpha matter in a 10:10:10 scanout buffer?

>From the OpenGL headers I can see the answer to my questions...
#define GL_RGB10                                0x8052
#define GL_RGB10_A2                          0x8059

OpenGL supports all of these:
#define GL_RGB10                                0x8052
#define GL_RGB12                                0x8053
#define GL_RGB16                                0x8054
#define GL_RGB10_A2                          0x8059
#define GL_RGBA12                               0x805A
#define GL_RGBA16                               0x805B

Are there 12 and 16 bit cmaps too?

-- 
Jon Smirl
jonsmirl@gmail.com
