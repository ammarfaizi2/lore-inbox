Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSKRCgv>; Sun, 17 Nov 2002 21:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSKRCgv>; Sun, 17 Nov 2002 21:36:51 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:30089 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261356AbSKRCgv>; Sun, 17 Nov 2002 21:36:51 -0500
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <87d6p63ui2.fsf@goat.bogus.local> <3DD5E65A.59243812@digeo.com>
	<87y97t34hs.fsf@goat.bogus.local>
	<20021117203213.K1407@almesberger.net>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Werner Almesberger <wa@almesberger.net>
Subject: Re: [PATCH] 2.5.47: strdup()
Date: Mon, 18 Nov 2002 03:43:43 +0100
Message-ID: <87n0o7mwbk.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Olaf Dietsche wrote:
>> +static inline char *strdup(const char *s) { return kstrdup(s, GFP_KERNEL); }
>
> Why hide what's really going on ? Better change the callers to use
> kstrdup.

Convenience and laziness. And I haven't seen any other strdup() use,
which uses different allocation flags. But it's there for everybody to
use, if they wish.

Regards, Olaf.
