Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUA0VLg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUA0VLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:11:36 -0500
Received: from mid-2.inet.it ([213.92.5.19]:61122 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S265267AbUA0VLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:11:34 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Andi Kleen <ak@muc.de>
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - REALLY SOLVED
Date: Tue, 27 Jan 2004 22:09:08 +0100
User-Agent: KMail/1.6
Cc: Eric <eric@cisu.net>, Andrew Morton <akpm@osdl.org>, stoffel@lucent.com,
       Valdis.Kletnieks@vt.edu, bunk@fs.tum.de, linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <200401270037.43676.eric@cisu.net> <20040127181554.GA41917@colin2.muc.de>
In-Reply-To: <20040127181554.GA41917@colin2.muc.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401272209.08708.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle Tuesday 27 January 2004 19:15, Andi Kleen ha scritto:

> Ok, found it. This patch should fix it.  The top level asm in process.c
> assumed that the section was .text, but that is not guaranteed in a
> funit-at-a-time compiler. It ended up in the setup section and messed up
> the argument parsing.  This bug could have hit with any compiler,
> it was just plain luck that it worked with newer gcc 3.3 and 3.4.

Confirmed here. 2.6.2-rc1-mm3 boots just fine with this patch; without patch 
it hangs just as described before.
(-funit-at-a-time enabled, of course).

Many thanks to all.

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
