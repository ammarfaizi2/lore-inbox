Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbTGDVKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 17:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbTGDVKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 17:10:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:11406 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266192AbTGDVKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 17:10:47 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jul 2003 23:25:12 +0200 (MEST)
Message-Id: <UTC200307042125.h64LPCq07319.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, mdharm-kernel@one-eyed-alien.net
Subject: Re: scsi mode sense broken again
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From mdharm@ziggy.one-eyed-alien.net  Fri Jul  4 23:09:37 2003

    Okay, so the question as I see it is this:
    Do we go back to use_10_for_ms = 0 for the default,
    or do we make the IMM driver set it to 0 in the
    slave_configure() function?

I agree completely - that is the question.
The answer I gave is

  -       sdev->use_10_for_ms = 1;
  +       sdev->use_10_for_ms = 0;
 
  It is possible to have use_10_for_ms == 1 as the default, but then
  all drivers that cannot handle that must change that setting privately.
  Maybe that is the future, but for today I would prefer
  the known working version.

Andries
