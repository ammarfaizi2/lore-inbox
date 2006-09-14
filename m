Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWINMlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWINMlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 08:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWINMlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 08:41:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53906 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751290AbWINMlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 08:41:05 -0400
Subject: Re: Assignment of GDT entries
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
In-Reply-To: <4508A191.1060203@vmware.com>
References: <450854F3.20603@goop.org>
	 <1158175001.3054.7.camel@laptopd505.fenrus.org> <4508681E.3070708@goop.org>
	 <4508711B.6060905@vmware.com>
	 <1158183322.16902.8.camel@localhost.localdomain>
	 <4508A191.1060203@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Sep 2006 14:03:53 +0100
Message-Id: <1158239034.21860.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-13 am 17:25 -0700, ysgrifennodd Zachary Amsden:
> that makes use of APM or PnP facilities.  There is the possibility 
> however, that such a program could sleep, run the idle thread, which 
> makes a call into some of these BIOS facilities, and then reschedules 
> the same program thread - which means FS/GS never get reloaded, thus 
> maintaining their corrupted values.  It is worth fixing, just not a high 
> priority.  I had a patch that fixed both APM and PnP at one time, but it 
> is covered with mold and now looks like a science experiment.  Shall I 
> apply disinfectant?

I think that would be useful, or just post up the mouldy one for someone
else to rework. If someone is hitting that kind of bug its going to be
pretty horrible to track down.

