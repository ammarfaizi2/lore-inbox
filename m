Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264535AbUDTW1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUDTW1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUDTW0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:26:51 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:19157 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S264296AbUDTT5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 15:57:52 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
Organization: Humboldt-Universitaet zu Berlin
To: linux-kernel@vger.kernel.org
Subject: Re: Support for building individual .ko's would be nice :-)
Date: Tue, 20 Apr 2004 21:57:52 +0200
User-Agent: KMail/1.5.4
References: <20040420185904.GA27037@ee.oulu.fi>
In-Reply-To: <20040420185904.GA27037@ee.oulu.fi>
Cc: Pekka Pietikainen <pp@ee.oulu.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404202157.52390.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 April 2004 20:59, Pekka Pietikainen wrote:
> I was told you're the man to bug about this :-)
>
> Having a slow box, a vendor kernel (+ kernel-source package with config
> for it) and a need to modify one line of a module, recompile it,
> replace existing module with it and continue business as usual
> made me notice kbuild doesn't seem to have a facility for this.
>
> What would be nice is (say)
>
> cp configs/xxx-i686.config .config
> emacs drivers/media/dvb/frontends/ves1820.c
> make drivers/media/dvb/frontends/ves1820.ko

Never tried before, but I would suggest to run
make M=drivers/media/dvb/frontends
at this place.

> cp ves1820.ko /lib/modules/...
save your old module first!

> rmmod ves1820; modprobe ves1820
rmmod ves1820
lsmod	# module unloaded?
modprobe ves1820

>
> Or am I missing something obvious that let me get just that one .ko
> without recompiling just about everything? (.o is easy, but that's
> not very useful :-) )

BTW: (asking the experts here) is it legal to hack a module like this??

I'd prefer to compile the whole thing (over night)!

Axel

