Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTEFPjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTEFPjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:39:35 -0400
Received: from corky.net ([212.150.53.130]:6801 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S263818AbTEFPjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:39:16 -0400
Date: Tue, 6 May 2003 18:51:21 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <Pine.LNX.4.44.0305061838090.9062-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You might have a derivative work after obtaining access to a
> non-exported interface.  If this is correct, binary-only modules
> can't do this and therefore they must stick to exported interfaces.

Thats an interesting question.  Who violates the license here ?  It can't
be the author of the binary driver (unless it was in breach before the
symbol was unexported).  Thats because it didn't change.  The user,
wishing to keep using his driver although the kernel changed and broke it,
generates and insmod's a module that re-exports a symbol that the module
relies upon.  However, the user didn't release any code so he can't be in
breach either.

Its just a method backwards compatibility of kernel modules.  Of course,
IANAL, so I may be wrong here.

One could argue that the binary module was in breach in the first place,
because of various reasons.  My point is that the re-exporting module
didn't change anything in terms of derived work.

	Yoav Weiss

