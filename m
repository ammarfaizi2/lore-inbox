Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267253AbUGVUtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267253AbUGVUtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUGVUtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:49:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:38907 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267253AbUGVUrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:47:52 -0400
From: zanussi@us.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16640.10183.983546.626298@tut.ibm.com>
Date: Thu, 22 Jul 2004 15:47:03 -0500
To: linux-kernel@vger.kernel.org
cc: karim@opersys.com, richardj_moore@uk.ibm.com, bob@watson.ibm.com,
       michel.dagenais@polymtl.ca
Subject: LTT user input
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of the things people mentioned wanting to see during Karim's LTT
talk at the Kernel Summit was cases where LTT had been useful to real
users.  Here are some examples culled from the ltt/ltt-dev mailing
lists:

http://www.listserv.shafik.org/pipermail/ltt/2004-July/000631.html
http://www.listserv.shafik.org/pipermail/ltt/2004-July/000630.html
http://www.listserv.shafik.org/pipermail/ltt/2004-July/000629.html
http://www.listserv.shafik.org/pipermail/ltt/2004-March/000559.html
http://www.listserv.shafik.org/pipermail/ltt/2003-April/000341.html
http://www.listserv.shafik.org/pipermail/ltt/2002-April/000199.html
http://www.listserv.shafik.org/pipermail/ltt/2001-December/000118.html
http://www.listserv.shafik.org/pipermail/ltt/2001-July/000064.html
http://www.listserv.shafik.org/pipermail/ltt/2001-April/000020.html

As with most other tools, we don't tend to hear from users unless they
have problems with the tool. :-( LTT has also been picked up by
Debian, SuSE, and MontaVista - maybe they have user input that we
don't get to see as well...

Another thing that came up was the impression that the overhead of
tracing is too high.  I'm not sure where the number mentioned (5%)
came from, but the peformance numbers we generated for the relayfs OLS
paper last year, using LTT as a test case, were 1.40% when tracing
everything but having the userspace daemon discard the transferred
data and 2.01% when tracing everything and having the daemon write all
data to disk.

The test system was a 4-way 700MHz Pentium III system, tracing all
event types (syscall entry/exit, interrupt entry/exit, trap
entry/exit, scheduling changes, kernel timer, softirq, process,
filesystem, memory management, socket, ipc, network device).  For each
number, we ran 10 kernel compiles while tracing.  Each 10-compile run
generated about 200 million events comprising about 2 gigabytes.

Tom

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

