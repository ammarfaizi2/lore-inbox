Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317876AbSHHTAG>; Thu, 8 Aug 2002 15:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317877AbSHHTAG>; Thu, 8 Aug 2002 15:00:06 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:41346 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317876AbSHHTAG>;
	Thu, 8 Aug 2002 15:00:06 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208081903.XAA03186@sex.inr.ac.ru>
Subject: Re: [PATCH] minor socket ioctl cleanup for 2.5.30
To: willy@debian.ORG (Matthew Wilcox)
Date: Thu, 8 Aug 2002 23:03:33 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020808184206.Q24631@parcelfarce.linux.theplanet.co.uk> from "Matthew Wilcox" at Aug 8, 2 09:45:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> i'm pretty sure you need a lock_kernel + unlock_kernel around the else.
> if two people are doing a F_SETOWN / SIOCSPGRP at the same time, you could
> have a race.

Well, acccording to another path by James, it needs a write_lock and
a read_lock at side checking for permissions. :-)

Alexey
