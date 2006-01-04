Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWADQZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWADQZD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 11:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWADQZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 11:25:03 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:61065 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751205AbWADQZA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 11:25:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZIk9jXw3nwVDCmYgbnSV2Ssve3yrY/SUcnZy7RrVBhkx6o21BPC1jpkO7oJRTUObTi0DhJSYGlTI8uySo1qUvWkMGA7GjVGd4eoMNIdOadV8nNzX+Ag/NSi3jtFHm87NLZbcY3OBLEosOnuaalEV96GbQs4vPdAVBiKHLcjNhxs=
Message-ID: <d120d5000601040825m1ee3f994g8ae45ca30819a7ae@mail.gmail.com>
Date: Wed, 4 Jan 2006 11:25:00 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: keyboard driver of 2.6 kernel
Cc: "P.Manohar" <pmanohar@lantana.tenet.res.in>, linux-kernel@vger.kernel.org
In-Reply-To: <1136363622.2839.6.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in>
	 <1136363622.2839.6.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2006-01-04 at 14:02 +0530, P.Manohar wrote:
> > Greetings,
> >      I have a small doubt in Linux kernel keyboard driver.
> > In 2.4 kernels the starting fuction of keyboard driver is "handle_scancode".
> > But in 2.6 kernels the keyboard interface
> > is changed drastically.  If you familiar with that can you tell me the starting
> > fuction of keyboard interace which gets
> > the scancodes in 2.6 kernels.
> >
> > Actually my paln is to stuff scancodes or keycodes to the keyboard buffer
> > , from there on the keyboard driver processes them.  I have done this for
> > 2.4 kernel.  I want to implement the same to 2.6 kernel.
> >
> > Is there any keyloggers which are implemented for 2.6 kernels?
>
> this is not r00tkitnewbies mailing list
>
> keyloggers are evil!
>

Anyway, if you want to read keypresses and other input events use
corresponding event device (/dev/input/eventX). If you want to feed
input events into the kernel you need to use "uinput" driver.

--
Dmitry
