Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWCRXlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWCRXlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 18:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWCRXlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 18:41:24 -0500
Received: from ozlabs.org ([203.10.76.45]:61598 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751136AbWCRXlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 18:41:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17436.39580.217348.85222@cargo.ozlabs.ibm.com>
Date: Sun, 19 Mar 2006 10:41:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Linus Torvalds <torvalds@osdl.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, janak@us.ibm.com,
       viro@ftp.linux.org.uk, hch@lst.de, ak@muc.de
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
In-Reply-To: <m1r74zzjbg.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0603161555210.3618@g5.osdl.org>
	<29085.1142557915@www064.gmx.net>
	<Pine.LNX.4.64.0603162140190.3618@g5.osdl.org>
	<m1r74zzjbg.fsf@ebiederm.dsl.xmission.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman writes:

> - We don't confuse users and developers about the inverted values of
>   the clone bits.

Given that the name starts with "un", I would *expect*
unshare(CLONE_FOO) to mean that I no longer want to share FOO.

If you want the argument to have the same sense as in the clone system
call, you will have to call it "share" rather than "unshare" (and then
explain to confused developers why they can't use it to start sharing
things that previously weren't shared :).

Paul.
