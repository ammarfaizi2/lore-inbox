Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUGNKUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUGNKUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267349AbUGNKUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:20:37 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:48141 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id S267345AbUGNKUg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:20:36 -0400
Message-ID: <40F509D8.608394E0@tv-sign.ru>
Date: Wed, 14 Jul 2004 14:24:24 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ravikiran G Thirumalai <kiran@in.ibm.com>
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> #ifdef __HAVE_ARCH_CMPXCHG

in wrong place.

static inline void refcount_init(refcount_t *rc)
...
#ifdef __HAVE_ARCH_CMPXCHG
...
#else /* !__HAVE_ARCH_CMPXCHG */
...
static inline void refcount_init(refcoun_t *rc)  <--- redefenition
                                 ^^^^^^^^        <--- and typo
Oleg.
