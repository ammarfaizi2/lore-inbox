Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbTGGENz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 00:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266801AbTGGENy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 00:13:54 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:15272 "HELO
	develer.com") by vger.kernel.org with SMTP id S266810AbTGGEMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 00:12:01 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix do_div() for all architectures
Date: Mon, 7 Jul 2003 06:26:08 +0200
User-Agent: KMail/1.5.9
Cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Andrew Morton <akpm@digeo.com>,
       Ian Molton <spyro@f2s.com>
References: <200307060133.15312.bernie@develer.com>
In-Reply-To: <200307060133.15312.bernie@develer.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307070626.08215.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 July 2003 01:33, Bernardo Innocenti wrote:

 >  - add __attribute__((pure)) to __div64_32() prototype so
 >    the compiler knows global memory isn't clobbered;

 Hmmm... I've just found out that the pure attribute wasn't
supported until gcc 2.96. Shall I get rid of it or maybe add
something in linux/compiler.h?

 Please note that __attribute__((const)) is not applicable
to this case according to gcc documentation.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


