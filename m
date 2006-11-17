Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932918AbWKQOop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918AbWKQOop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933629AbWKQOop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:44:45 -0500
Received: from nz-out-0102.google.com ([64.233.162.194]:50933 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932918AbWKQOoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:44:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NsYS6nK+BUCcRroZFWAIA7SlbZZyKB9Cf4dBIJWKWDoqvHNrQwGLszuMBXHvVr2b7IUK9ynTg1vK40swvkpfG662pQkanVKdZElWN6gWLIsYsouSpqqh6cN+N7LuZ3X7vjcBhqiscFLM7i9p9JTOawThxB3a8sr2Hae7EJNIouc=
Message-ID: <6844644e0611170644n32aeb454p72e8b1ec9733f30a@mail.gmail.com>
Date: Fri, 17 Nov 2006 09:44:43 -0500
From: "Doug Reiland" <dreiland@gmail.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel panic in 2.6.19-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton sorry I missed your reply:

To recap, I said:
     FYI, I had to get CONFIG_SYSCTL_SYSCALL set to solve my
2.6.19-rc1 boot panic.
     Actually, I couldn't get CONFIG_SYSCTL_SYSCALL=y to stick so I
modified kernel/sysctl.c's ifdefs.

You said:
    What boot panic was that?
    It depends on CONFIG_EMBEDDED.

The panic was because init died. I get an error message about unknown
library version (exact message I can't recall) and then the panic.

Again, I am running a new 2.6.x kernel on an old distribution so my
init binary or run-time loader might still be depending on SYSCTL.

I am now playing with a x86_64 kernel and saw this same problem. Your
CONFIG_EMBEDDED hint helped. I set that and CONFIG_SYSCTL_SYSCALL
stays on.

Thanks again and sorry for not attaching this to the original email thread.
