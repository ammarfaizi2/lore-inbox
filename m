Return-Path: <linux-kernel-owner+w=401wt.eu-S1161178AbXAHHtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbXAHHtH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 02:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161174AbXAHHtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 02:49:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:30099 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161181AbXAHHtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 02:49:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=paRSwgQU9kBhqQFsTanWxf2GoD9KijSInttE7qVHFXQKLoIxzw4nwS05cvjgoYKFTXZRHtyWK3y4+DfNX2J+EEs4mPzHy0Bvk6E81SRp3f7MKbF2E4ivCx2mw6F+YuTDaGzOiXAvPf/3NsZFVCn1W/6O3zVWRDnE7JsxjeI46f8=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Amit Choudhary'" <amit2030@yahoo.com>,
       "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] include/linux/slab.h: new KFREE() macro.
Date: Sun, 7 Jan 2007 23:49:07 -0800
Message-ID: <000501c732f9$7e3386a0$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <108973.65122.qm@web55613.mail.re4.yahoo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AccyrZjwj2VNA0nGRg2/hr7V0cMv6gAS5Zgg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any strong reason why not? x has some value that does not 
> make sense and can create only problems.

By the same logic, you should memset the buffer to zero before freeing it too.

> And as I explained, it can result in longer code too. So, why 
> keep this value around. Why not re-initialize it to NULL.

Because initialization increases code size.

It's a silly patch.

> If x should not be re-initialized to NULL, then by the same 
> logic, we should not even initialize local variables. And all 
> of us know that local variables should be initialized.
> 
> I would like to know a good reason as to why x should not be 
> set to NULL.


