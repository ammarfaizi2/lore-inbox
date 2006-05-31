Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWEaECO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWEaECO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWEaECN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:02:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:55590 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751642AbWEaECN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:02:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ok9WuOR124gASdqZQ8er5KPsBuONqMFJY9S9SADuF5JcroR0F9Xt7QiV5i+9cEm6yjKxNHuoi1Umf/qNYdzFaqRualiCMW8oUWplW4YNUYMQBt+yJW7JgICOcEUuoGN4kHWmXwqMcIr/OK1ubF/ql//FsD0hIyAPxkOdrsAv898=
Message-ID: <9e4733910605302102y491de627n7dabfbda0ed365b1@mail.gmail.com>
Date: Wed, 31 May 2006 00:02:12 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605302314.25957.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com>
	 <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
	 <200605302314.25957.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, D. Hazelton <dhazelton@enter.net> wrote:
> On Tuesday 30 May 2006 23:27, Jon Smirl wrote:
> > On 5/30/06, Dave Airlie <airlied@gmail.com> wrote:
> > > Actually the suspend/resume has to be in userspace, X just re-posts
> > > the video ROM and reloads the registers... so the repost on resume has
> > > to happen... so some component needs to be in userspace..
> >
> > I'd like to see the simple video POST program get finished. All of the
> > pieces are lying around. A key step missing is to getting klibc added
> > to the kernel tree which is being worked on.
>
> True. But how long is it going to be before klibc is merged?

The merged tree is here:
git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git

I don't know the plans for when the final merge will happen.

A standalone version of klibc is also available here:
http://www.kernel.org/pub/linux/libs/klibc/
Looks like version 1.3 is the latest

The standalone version is perfectly fine for development. You only
need to worry about the kernel tree version when it everything is
finished. I've used klibc for several apps like this and it is a great
tool. The binaries it produces are tiny.

vbetool is a good way to practice resetting the cards if you do the
mods to /sys/class/firmware. The other features like emu86 support can
be added later.

-- 
Jon Smirl
jonsmirl@gmail.com
