Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWDVTWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWDVTWK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWDVTWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:22:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:32462 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751020AbWDVTWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:22:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=fpglLJFnzPMSmApqJA/ND+d5oOfa04HxCyUz4hzMjyBTX3C/FJXWHJ12k+t5RwVnkwouG+4qDu7Yoj6Z/8eEC3i4Y9ZvrDC0GuvNo7DHclYTGN3nJMpeB7kFdxN6hXi2/ayZvQKEUPIzrOSp4IYfHjCBwyHFLPUeCuxDVQqJJGI=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'Paul Mackerras'" <paulus@samba.org>,
       "'Pekka Enberg'" <penberg@cs.helsinki.fi>,
       "'Andrew Morton'" <akpm@osdl.org>, "'James Morris'" <jmorris@namei.org>,
       <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: RE: kfree(NULL)
Date: Sat, 22 Apr 2006 12:22:03 -0700
Message-ID: <001b01c66642$0abdbf80$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <444A7E85.4030803@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcZmP8dX1Er0H/2tRrOH4rppve9EqgAAXjQQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It can reduce readability of the code [unless it is used in 
> error path simplification, kfree(something) usually suggests 
> kfree-an-object].

Consistency in coding style improves readability. Redundancy reduces readability.

The interface is simple and clear, and has been documented for decades, that is kfree (and free) accepts NULL. There is no ambiguity
here.

If you think "if (obj) kfree (obj);" is more readable than "kfree(obj);", fix the API to enforce it.

But if the kernel tree is full of "some caller checks NULL while others not", I hardly see it as readable. It'd just be confusing.
 
> I don't actually like kfree(NULL) any time except error 
> paths. It is subjective, not crazy talk.

Documented interface is not subjective.

