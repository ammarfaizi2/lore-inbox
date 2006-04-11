Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWDKTfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWDKTfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWDKTfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:35:07 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:39821 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750825AbWDKTfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:35:05 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Dumpable tasks and ownership of /proc/*/fd
To: "Eric W. Biederman" <ebiederm@xmission.com>, Petr Baudis <pasky@suse.cz>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 11 Apr 2006 21:30:32 +0200
References: <5Zkqr-5LI-5@gated-at.bofh.it> <5ZXrM-3qg-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FTOZg-0000av-IY@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> Speaking of things why does the *at() emulation need to touch
> /proc/self/fd/*?  I may be completely dense but if the practical
> justification for allowing access to /proc/self/fd/ is that we
> already have access then we shouldn't need /proc/self/fd.
> 
> I suspect this a matter of convenience where you are prepending
> /proc/self/fd/xxx/ to the path before you open it instead of calling
> fchdir openat() and the doing fchdir back.  Have I properly guessed
> how the *at() emulation works?

Think about threads or siglongjmp(sp?).
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
