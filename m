Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVBLRb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVBLRb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 12:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVBLRb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 12:31:58 -0500
Received: from smtpout5.uol.com.br ([200.221.4.196]:25059 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261167AbVBLRb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 12:31:56 -0500
Date: Sat, 12 Feb 2005 15:31:50 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Warnings when compiling apm
Message-ID: <20050212173150.GD13729@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

For many kernel releases, including 2.6.11-rc3-mm2, I ve been getting
warnings like the following when compiling the apm driver:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  CC      arch/i386/kernel/apm.o
arch/i386/kernel/apm.c: In function `suspend':
arch/i386/kernel/apm.c:1191: warning: `pm_send_all' is deprecated (declared at include/linux/pm.h:126)
arch/i386/kernel/apm.c:1241: warning: `pm_send_all' is deprecated (declared at include/linux/pm.h:126)
arch/i386/kernel/apm.c: In function `check_events':
arch/i386/kernel/apm.c:1357: warning: `pm_send_all' is deprecated (declared at include/linux/pm.h:126)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Unfortunately, I read the code in pm.h and apm.c to see if I could fix the
problem, but I am just not sure if killing the calls to pm_send_all is
something that should be done or not (the function currently is just an
inline function that returns 0).

Similar things can be said about pm_register, pm_unregister,
pm_unregister_all and pm_send.



Thanks for any guidance, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
