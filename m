Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTLDQMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTLDQMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:12:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:11168 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262575AbTLDQMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:12:22 -0500
Date: Thu, 4 Dec 2003 17:12:20 +0100 (MET)
From: "Peter Bergmann" <bergmann.peter@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: oom killer in 2.4.23
X-Priority: 3 (Normal)
X-Authenticated: #13246506
Message-ID: <15498.1070554340@www7.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would appreciate if someone could answer the following question:

obviously oom killer has been removed from 2.4.23.
the result is _bad_ in my special environment.
(xserver gets killed instead of application)

i'm sure you had very good reasons for removing the oom killer.

nevertheless i've seen, that oom_kill.c is still in mm/ but disabled with
#if 0
and out_of_memory() is not called anymore from vmscan.c.

is it sufficient to remove the #if 0 from oom_kill.c,  call out_of_memory()
from 
vmscan.c again and add PF_MEMDIE to sched.h in order to get the "old"
behaviour ?
or will this result in - i don't know - something horrible?

thanks for your help!

cheers,
pet
(please cc me as i'm not (yet) subscribed.)
 


-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


