Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVGXM7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVGXM7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 08:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVGXM7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 08:59:07 -0400
Received: from femail.waymark.net ([206.176.148.84]:19423 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261610AbVGXM7G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 08:59:06 -0400
Date: 24 Jul 2005 12:56:36 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
To: linux-kernel@vger.kernel.org
Message-ID: <803f51.f83f12@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> Linus Torvalds wrote to All and Chuck Ebbert <=-

[..]

 Chuck>
      >                         "m" ((tsk)->thread.i387.fxsave))
      >
      > because that's the largest possible operand that could end up
      > being read?

 LT> Yes, I ended up fixing that already (along with handling the fxsave
 LT> case too).
[..]

 2.6.13-rc3-git5 lags -git4 on nbench's bitfield test, a part of its
memory index, eg typical runs
-git5
BITFIELD            :      1.1589e+07  :       1.99  :       0.42
-git4
BITFIELD            :      2.1892e+07  :       3.76  :       0.78

lmbench has slower context switch numbers for -git5.

--- MultiMail/Linux v0.46
