Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUFIMjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUFIMjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUFIMjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:39:02 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:914 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S266092AbUFIMgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:36:47 -0400
Date: Wed, 9 Jun 2004 14:36:33 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel@vger.kernel.org
Subject: [STACK] weird code in some isdn drivers
Message-ID: <20040609123633.GH21168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten, Kai,

while I agree that this is a measurement bug, it's not exacly fun to
look at the code in question.  Can you please find a solution for
hscx_irq.c?

Either transform it into a header and uninline some of the longer
functions or make the functions global and add the necessary header
and Makefile-line.  In any case, I don't like to see something like
#include "hscx_irq.c"

stackframes for call path too long (268435490):
    size  function
       0  IsdnCardState->irq_func
268435466  teles3_interrupt
      24  hscx_empty_fifo
       0  read_fifo
       0  insb

Jörn

-- 
People will accept your ideas much more readily if you tell them
that Benjamin Franklin said it first.
-- unknown
