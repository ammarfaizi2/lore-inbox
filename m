Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131350AbRCULjK>; Wed, 21 Mar 2001 06:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131351AbRCULjA>; Wed, 21 Mar 2001 06:39:00 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:8205 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131350AbRCULip>;
	Wed, 21 Mar 2001 06:38:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Manoj Sontakke <manojs@sasken.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: initialisation code 
In-Reply-To: Your message of "Wed, 21 Mar 2001 22:00:51 +0530."
             <Pine.LNX.4.21.0103212147400.884-100000@pcc65.sasi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Mar 2001 22:37:54 +1100
Message-ID: <24505.985174674@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001 22:00:51 +0530 (IST), 
Manoj Sontakke <manojs@sasken.com> wrote:
>	I have a initlisation function (just like pktsched_init in
>TC). Can anyone tell me, where in the kernel boot sequence should I make a
>call to my initialisation function.

Welcome to the wonderful world of magic initialisation.

(1) Declare your initialisation function as int __init foo_init(void).

(2) Decide when your function needs to be called, e.g. after initialisers
    for A, B, C but before initialisers for X, Y, Z.

(3) Edit the Makefile to insert obj-$(CONFIG_FOO) after the objects
    that contain initialisers A, B, C and before the objects for
    initialisers X, Y, Z.

(4) Document why the order of this routine is required!  Without docs
    in the Makefile we have no idea if object order is correct or not.

