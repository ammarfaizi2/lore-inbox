Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265225AbUELUkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUELUkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUELUkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:40:21 -0400
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:58886 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP id S265225AbUELUkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:40:05 -0400
Message-ID: <15FDCE057B48784C80836803AE3598D50627ACD5@racerx.ixiacom.com>
From: Jan Olderdissen <jan@ixiacom.com>
To: "'Andrew Morton'" <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: davidel@xmailserver.org, jgarzik@pobox.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: RE: MSEC_TO_JIFFIES is messed up...
Date: Wed, 12 May 2004 13:40:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Couple nitpicks:

> #if HZ=1000

#if HZ==1000

> #define	MSEC_TO_JIFFIES(msec) (msec)
> #define JIFFIES_TO_MESC(jiffies) (jiffies)
> #elif HZ=100

#elif HZ==100

> #define	MSEC_TO_JIFFIES(msec) (msec * 10)
> #define JIFFIES_TO_MESC(jiffies) (jiffies / 10)

#define JIFFIES_TO_MSEC(jiffies) (jiffies / 10)

> #else
> #define	MSEC_TO_JIFFIES(msec) ((HZ * (msec) + 999) / 1000)
> #define	JIFFIES_TO_MSEC(jiffies) ...
> #endif

Jan
