Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbTJUPUz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTJUPUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:20:55 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:38278 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263161AbTJUPUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:20:53 -0400
Message-ID: <175701c397e6$b36e5310$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Blockbusting news, results are in
Date: Wed, 22 Oct 2003 00:18:33 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw replied to me:

> > After a few other experiments, I used smartctl to direct the drive to do a
> > long self-test.  When it completed, we observed that the drive had
> > self-diagnosed a read failure on the same bad sector number as always, and
> > we observed that the drive did not reallocate the bad block during long
> > self-tests.
>
> Maybe the drive can't remap the block because there's no free space in
> the remap area available any more...

As previously reported about twice in this thread, the first time I ran
"smartctl -a" it reported that the quantities of reallocated sector events
and reallocated sector count were both 1, and when I ran it again after the
first long self-test, both of these quantities had increased to 2.  If there
were no room in the remap area, then how did the remaps increase from 1 to 2
while the permanently bad sector remained non-remapped and permanantly bad?

Here's more results.  The quantities of reallocated sector events and
reallocated sector count have both increased to 3.  Meanwhile the
permanently bad sector remains permanently bad.  I think that there is still
room remaining in the remap area.

By this time I think my friends at Toshiba agree that Toshiba's firmware is
inadequate, though participants in this LKML thread are about evenly divided
on the issue.  It seems that Maxtor's firmware is better, though I notice
the silence regarding my questions of customer non-service and uncertain
warranties (when Maxtor distributed one drive with two incompatible sets of
jumpering instructions).  And other manufacturers still aren't saying
whether their firmware is adequate.  It still seems that either Linux must
be made to work around known bad blocks or else hard disks and Linux cannot
be used together on a computer.

