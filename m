Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSH0LhG>; Tue, 27 Aug 2002 07:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSH0LhG>; Tue, 27 Aug 2002 07:37:06 -0400
Received: from zeus.kernel.org ([204.152.189.113]:60563 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S315540AbSH0LhG>;
	Tue, 27 Aug 2002 07:37:06 -0400
Date: Tue, 27 Aug 2002 13:28:05 +0200
Message-Id: <200208271128.g7RBS5430654@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: linux-kernel@vger.kernel.org
Subject: Re: block device/VM question
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PTB  wrote:
> Is there any way of turning off VMS caching for a block device?

Well, I've been reading the 2.5.31 code, and it looks like if
the block device node is opened O_DIRECT and it has an
i_mapping->a_ops->direct_IO method, then file systems will use it
for read/write and won't go thorgh VMS.  I'll investigate.

Does anyone have a pointer for where to go in the 2.4 code?

Peter
