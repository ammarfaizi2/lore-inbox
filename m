Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTEFNst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTEFNst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:48:49 -0400
Received: from elin.scali.no ([62.70.89.10]:62098 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S263718AbTEFNss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:48:48 -0400
Subject: FYI: General solution to the disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052229679.15887.67.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 May 2003 16:01:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those that kept up with the lastest thread on the
EXPORT(syscall_table) saga:

The general solution for those that must have syscall traps is of course
to change the dest address in the trap gate and the MSR's for
syscall/sysenter to trap all system calls before ENTRY(system-call).  

Remember to do it on all CPU's :-)

Cheers
	TJ


-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

