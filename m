Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265011AbUFMGeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265011AbUFMGeV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 02:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbUFMGeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 02:34:20 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:43203 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S265011AbUFMGeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 02:34:19 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel/module compiler version problem 
In-reply-to: Your message of "Fri, 11 Jun 2004 15:16:00 -0400."
             <40CA04F0.9000307@nortelnetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Jun 2004 16:34:07 +1000
Message-ID: <29225.1087108447@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2004 15:16:00 -0400, 
Chris Friesen <cfriesen@nortelnetworks.com> wrote:
>I'm running 2.4.22, build with gcc 3.3.1, modutils 2.4.22.
>
>I have an ATM driver that is shipped with a binary blob and a source code shim. 
>  It compiles fine.  When I go to load it, I get the following error:
>
>"The module you are trying to load is compiled with a gcc
>version 2 compiler, while the kernel you are running is compiled with
>a gcc version 3 compiler. This is known to not work."
>
>Presumably the binary blob was compiled with gcc 2.x?  Is there any way to 
>override this?  "insmod -f" doesn't seem to work.

That patch originally came from RedHat, and was included in modutils
2.4.22.  From RH Bugzilla 73732.

"The insmod in Red Hat Linux 8.0 looks for modules and kernels which do
not have a matching gcc version. This is done because both the base and
the Red Hat kernel ABI for gcc 2 and gcc 3 built kernels are not the
same. This is due to workarounds for old (egcs) compiler bugs which
change the padding in kernel data structures.

Other vendors using gcc 3 series compilers received many strange bug
reports that turned out to be gcc 2 and gcc 3 module mixups. We saw the
same problems and verified the cause in our earlier beta releases. In
order to assist our customers Red Hat extended insmod to detect the
problem case and display an error message."

