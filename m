Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbUKVSdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbUKVSdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbUKVScE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:32:04 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13727 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262306AbUKVSVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:21:14 -0500
Date: Mon, 22 Nov 2004 19:21:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
In-Reply-To: <Pine.LNX.4.58.0411220812580.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.53.0411221918050.27104@yvahk01.tjqt.qr>
References: <20041120143755.E13550@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com>
 <Pine.LNX.4.58.0411211433540.20993@ppc970.osdl.org>
 <Pine.LNX.4.53.0411212343340.17752@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0411211644200.20993@ppc970.osdl.org>
 <Pine.LNX.4.53.0411221132550.8845@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0411220812580.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>For example, the "nested function" thing makes something as simple as a
>missing end brace cause the error reporting to be totally off, when gcc

Oh yeah I've experienced that myself (and ever since, fear nested functions).
The compiler generates like "nested_function.0" for a nested function entitled
"nested_function". So far so good, but GDB does not now "nested_function.0",
even if it is a valid symbol according to `nm`. Sigh.

>Same goes for the "extended lvalues". They are not only insane, but they
>mean that code like
>	(0,i) = 1;
>extension - does anybody actually admit to ever _using_ comma- expressions
>for assignments?)

Not in C, at least. And neither in C++. (Only Perl if you ask, but that has
vastly different semantics for "($thing,$anoterthing)".)

I totally agree that some extensions are like superfluous. Some may say "nice
to have", but go make a survey and ask how many users use them. Bet zero on
the average? ;)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
