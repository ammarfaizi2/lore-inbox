Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130374AbRAWXGs>; Tue, 23 Jan 2001 18:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131781AbRAWXGi>; Tue, 23 Jan 2001 18:06:38 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:42502 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130374AbRAWXGd>;
	Tue, 23 Jan 2001 18:06:33 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: stripping symbols from modules 
In-Reply-To: Your message of "Tue, 23 Jan 2001 17:34:15 CDT."
             <FEEBE78C8360D411ACFD00D0B747797188095C@xsj02.sjs.agilent.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Jan 2001 10:06:23 +1100
Message-ID: <27955.980291183@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001 17:34:15 -0500, 
"MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com> wrote:
>Is there any way to strip symbols from modules .o files ?

Not safely.  Some symbols must be kept to assist insmod and hot
plugging, strip does not know about these special symbols.

Why do you need to strip modules anyway?  I don't see the point unless
you are critically low on disk space.  Stripping the symbols makes it
much harder to debug oops in modules, ksymoops needs all the symbols.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
