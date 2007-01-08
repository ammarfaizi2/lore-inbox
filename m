Return-Path: <linux-kernel-owner+w=401wt.eu-S932636AbXAHI50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbXAHI50 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbXAHI50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:57:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:60056 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161201AbXAHI5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:57:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=HNAJ+/TK9TlwBtFtvcKln6GVFrvCULCyFCWJoA5sBNV5L/adNieY9882JQTfRPoTSho/DkT59TmrocGRiEqW3XcPpKgqUEccpOBzIKXEJZjz+IKFVMBbCaFqYI9J50z9Uht+txdEJ8lV5wd+pzqDmrVSbOXxkZ64vY9c5dh2nQ0=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Amit Choudhary'" <amit2030@yahoo.com>,
       "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] include/linux/slab.h: new KFREE() macro.
Date: Mon, 8 Jan 2007 00:57:27 -0800
Message-ID: <000901c73303$08fec020$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <110013.54208.qm@web55614.mail.re4.yahoo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: Accy+9XjbMzJyTfwSU+z+/pm9NNttQABfniw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- Hua Zhong <hzhong@gmail.com> wrote:
> 
> > > Any strong reason why not? x has some value that does not 
> > > make sense and can create only problems.
> > 
> > By the same logic, you should memset the buffer to zero 
> before freeing it too.
> > 
> 
> How does this help?

It doesn't. I thought that was my point?
 
> > > And as I explained, it can result in longer code too. So, why 
> > > keep this value around. Why not re-initialize it to NULL.
> > 
> > Because initialization increases code size.
> 
> Then why use kzalloc()? Let's remove _ALL_ the initialization 
> code from the kernel.

You initialize before use, not after.

> Attached is some code from the kernel. Expanded KFREE() has 
> been used atleast 1000 times in the
> kernel. By your logic, everyone is stupid in doing so. 
> Something has been done atleast 1000 times
> in the kernel, that looks okay. But consolidating it at one 
> place does not look okay. I am listing
> some of the 1000 places where KFREE() has been used. All this 
> code have been written by atleast 50
> different people. From your logic they were doing "silly" things.

Maybe you should first each one of them and see why they do it. 
And if there is no purpose than "better be safe than sorry", 
maybe you can then submit a patch to fix it.

