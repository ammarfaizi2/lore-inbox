Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965304AbVKBWLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965304AbVKBWLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965305AbVKBWLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:11:19 -0500
Received: from vscan.kent.edu ([131.123.246.3]:3991 "EHLO smtp.kent.edu")
	by vger.kernel.org with ESMTP id S965304AbVKBWLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:11:19 -0500
From: <ppunnam@kent.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <1932830193449a.193449a1932830@kent.edu>
Date: Wed, 02 Nov 2005 17:11:19 -0500
X-Mailer: iPlanet Messenger Express 5.2 Patch 2 (built Jul 14 2004)
MIME-Version: 1.0
Content-Language: en
Subject: send_sigqueue problem..
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

i am trying to use the linux signaling to signal a user process from 
the kernel..
i require a reliable(without any signal loss) and fast signaling 
mechanism.
i tried to use the send_sigqueue to send the signals...here what i did

1) creted the sigqueue structure using the sigqueue_alloc()..
2) called the send_sigqueue() function...
it worked fine for some time(around 1000 sig) but after that 
sigqueue_alloc failing..may be becuse of not enough memory  available 
to allocate sigqueue..
i got few question about this..

1) does sigqueue structure need to be removed explisitly or it will be 
autometically cleared after the signal delivery (i did't used the 
sigqueue_free() becuse i dont know when the signal is deliverd).
2)there is any another way i can implement such a signaling mechanism.

i will be thankful for your help...

-prady

 
