Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270810AbTGVMkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270811AbTGVMkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:40:09 -0400
Received: from shackc.compushack.de ([195.145.90.67]:48390 "EHLO
	shackc.compu-shack.com") by vger.kernel.org with ESMTP
	id S270810AbTGVMkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:40:05 -0400
Subject: Re: CPU Lockup with 2.4.21 and 2.4.22-pre
From: Michael =?ISO-8859-1?Q?Tro=DF?= <mtross@compu-shack.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <0001F474@gwia.compu-shack.com>
References: <0001F474@gwia.compu-shack.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Compu-Shack Production
Message-Id: <1058878505.2232.122.camel@mtross2.csintern.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 22 Jul 2003 14:55:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Die, 2003-07-22 um 13.51 schrieb Udo A. Steinberg:

> Note that the fddi patch includes a patch you've previously sent me, which
> isn't present in the driver on your website.

As you might know, the Compu-Shack fddi products reached end-of-life
last year.

> If you need more information, let me know. Also if you have any tips or
> patches that would help in debugging the issue, I'm happy to try them.

As I can't locate the code sequence in my driver module, please check it
with your compiled kernel:
  objdump -d vmlinux | grep -A 20 "7e f5" | grep csfddi
or module:
  hexdump -e '32/1 "%02x " "\n"' csf.o | grep "7e f5 e9 e8"
Do you get a result like the code line from your oops, which eip is
referring to?

> MT> What makes you believe this? There is no matching code sequence like the
> MT> one from your dump in the driver, to be exact: in a driver compiled with
> MT> gcc 3.3 and kernel 2.4.21.
> 
> The fact that the backtrace in the decoded oops looks like the lockup
> happened in the fddi driver led me to the conclusion that this may be
> the culprit.

But you got two different decoding results, didn't you ?!

> Regards,
> -Udo.

Regards,
Michael

