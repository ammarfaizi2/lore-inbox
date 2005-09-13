Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbVIMMs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbVIMMs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbVIMMs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:48:56 -0400
Received: from 216-54-166-16.gen.twtelecom.net ([216.54.166.16]:25557 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S932638AbVIMMsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:48:55 -0400
Message-ID: <4326CAB3.6020109@compro.net>
Date: Tue, 13 Sep 2005 08:48:51 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HZ question
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.12.33
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to know the kernels value of HZ in a userland app.

getconf CLK_TCK
      and
hz = sysconf (_SC_CLK_TCK)

both seem to return CLOCKS_PER_SEC which is defined as USER_HZ which is 
defined as 100.

include/asm/param.h:

#ifdef __KERNEL__
# define HZ       1000   /* Internal kernel timer frequency */
# define USER_HZ  100    /* .. some user interfaces are in "ticks" */
# define CLOCKS_PER_SEC  (USER_HZ)       /* like times() */
#endif

Thanks in advance for any help
Mark
