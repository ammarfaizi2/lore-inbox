Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbTIXQJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbTIXQJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:09:49 -0400
Received: from web12606.mail.yahoo.com ([216.136.173.229]:45489 "HELO
	web12606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261442AbTIXQJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:09:49 -0400
Message-ID: <20030924160948.31778.qmail@web12606.mail.yahoo.com>
Date: Wed, 24 Sep 2003 18:09:48 +0200 (CEST)
From: =?iso-8859-1?q?emmanuel=20ALLAUD?= <eallaud@yahoo.fr>
Subject: A proper way to yield for interactive tasks
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all,
this way was brought on the XFree-devel list : say you
have a video driver which wants to feed a video card
using DMA (in general using big chunks ~1MB for
performance reasons). Once the buffer is filled up,
you know this will take time to be processed by the
card, so you want to release the CPU, but you don't
want to wait too long for getting the CPU back for
interactivity reason. People are using sched_yield for
now (not all I guess), is that the good solution?
I must add that this is all in user-space, and the DMA
case is not the only case where we need to yield but
not too long.
I have seen things related in the archives but I did
not find something clear on that matter.
TIA
Bye
Manu

PS : could you please CC me, I am not subscribed to
this list (and my mailbox is already crowded ;-)

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
