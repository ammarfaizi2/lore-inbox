Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269119AbRH0VfE>; Mon, 27 Aug 2001 17:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269174AbRH0Vey>; Mon, 27 Aug 2001 17:34:54 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:5126 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S269158AbRH0Vef>; Mon, 27 Aug 2001 17:34:35 -0400
Subject: Re: Updated Linux kernel preemption patches
From: Robert Love <rml@tech9.net>
To: Andrey Nekrasov <andy@spylog.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010828011251.A32227@spylog.ru>
In-Reply-To: <998877465.801.19.camel@phantasy>
	<20010827093835.A15153@oisec.net> <3B8AA02D.6F7561AB@lexus.com>
	<998941465.1993.9.camel@phantasy>  <20010828011251.A32227@spylog.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 27 Aug 2001 17:35:22 -0400
Message-Id: <998948123.12268.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-08-27 at 17:12, Andrey Nekrasov wrote:
> I am doing:
> 
> make clean
> make menuconfig (load my config; enable/disable option if need)
> make dep
> make bzImage
> (break with error)
> 
> 
> Where should be "make oldconfig" ?

You probably don't need to be doing oldconfig if you are doing
menuconfig and correctly filling everything out, although the correct
place to do it would be before menuconfig (let oldconfig prompt you on
new config options). thus,

`make oldconfig menuconfig dep clean bzImage'

is what you should do. if you are running `make dep', my theory is
wrong, and admittedly I don't know why it is not working for you.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

