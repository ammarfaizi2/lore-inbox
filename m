Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbTDOM0L (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTDOM0L 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:26:11 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:16860 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S261287AbTDOM0I 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:26:08 -0400
From: "Mathur, Shobhit" <Shobhit_mathur@adaptec.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Message-ID: <3E9CA669.FEF1DDF7@adaptec.com>
Date: Wed, 16 Apr 2003 06:10:09 +0530
Organization: Adaptec
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
Subject: linux-source debugging with kgdb-patch
X-Priority: 1 (Highest)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

BACKGROUND:

I was keen to see kgdb running  for  purely academic reasons. Thus,
I made a setup of 2 machines for source-level debugging of the
linux-kernel. The procedure mentioned on the web-site
[ kgdb.sourceforge.net] has  been adhered to.  I was able to
successfully configure the setup. Also, I decided to use "ddd" front-end
on gdb [local m/c]  for debugging  the kgdb-patched kernel on the remote
machine, which is the usual setup for such debugging-efforts.
    The m/c to be debugged stops with the message "Waiting for
connection from remote gdb..." until the "target remote" command is run
from the "gdb" prompt of "ddd", upon which the m/c to be debugged
continues it's bootup till it shows the command-prompt.

PROBLEM:

I was interested in setting a break-point in start_kernel thru' "ddd"
such that the boot-up  of the m/c to be debugged could be analysed
step-by-step remotely. Though, I am able to set the breakpoint in
start_kernel(),
the commands "run" or "continue" on the "gdb" prompt, only throw up the
following errors :

(gdb) info break
Num Type           Disp Enb Address    What
7   breakpoint      keep  y   0xc027e7f0 in start_kernel at
init/main.c:614
(gdb) run
warning: shared library handler failed to enable breakpoint
warning: Cannot insert breakpoint 7:
Cannot access memory at address 0xc027e7f0

QUESTION:

I very strongly suspect that this exercise follows a particular sequence
of steps to get it right. Either I am missing some step or I am not
following the "order".  In either case, I would be glad to receive some
help/comments on my academic endeavour to be able to remotely debug the
kernel.

- Kindly let me know a solution

- TIA

- Shobhit Mathur
