Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279352AbRJWKVh>; Tue, 23 Oct 2001 06:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279353AbRJWKV2>; Tue, 23 Oct 2001 06:21:28 -0400
Received: from ns.sysgo.de ([213.68.67.98]:43763 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S279352AbRJWKVU>;
	Tue, 23 Oct 2001 06:21:20 -0400
Message-ID: <3BD5444D.DCD355BB@sysgo.de>
Date: Tue, 23 Oct 2001 12:19:57 +0200
From: Alex Zuepke <azu@sysgo.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: (ppc) multiple #include bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i had some compiler errors when playing with the linux trace toolkit
(ltt) and tracked them down:

there is no prevention against multiple #includes in
include/asm-ppc/time.h.
and include/asm-ppc/smplock.h doesn't seem to be safe, too.

i tried kernel 2.4.13.

please add the #ifndef _filename_ \ #define _filename_ \ #endif stuff.


regards,

alex
