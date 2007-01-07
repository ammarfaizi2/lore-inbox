Return-Path: <linux-kernel-owner+w=401wt.eu-S932426AbXAGIPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbXAGIPk (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 03:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbXAGIPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 03:15:40 -0500
Received: from web55601.mail.re4.yahoo.com ([206.190.58.225]:42741 "HELO
	web55601.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932426AbXAGIPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 03:15:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ISWMORdja0YFXJExw0ymn/vJ4AO1w9ZoCGS1vPp9EFFjagZmtrKYD2aDPsn/C23Mo0PeYUbFdDfombQXK/NS3cYw2z+8giBK5cIWj9Wxbu9NjTeFYcoaASdl3E3orZL6y9bBKq02MDCFfTzeN8fsNl/hj4AaQ8Q4ZgtZ5Ntwnp4=;
X-YMail-OSG: .zh62wAVM1mRgjYqZEkVTsTweppaDq2H3FkAVmmN1c4boA3To765jY2It_Vumae2684AQVSOSw8.pUofs6qGx5MHAYjVjn024iAboHJT5Ks9Oq1.Fxv3FkvaiCJivaofUH6nHwPIKw3_ppBioER6jBUZc0Nm1fW3Gr6fZOq..xHqmCrtBFJxyOanCexy
Date: Sun, 7 Jan 2007 00:15:38 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: [DISCUSS] Making system calls more portable.
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <722886.55398.qm@web55601.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wanted to know if there is any inclination towards making system calls more portable. Please let
me know if this discussion has happened before.

Well, system calls today are not portable mainly because they are invoked using a number and it
may happen that a number 'N' may refer to systemcall_1() on one system/kernel and to
systemcall_2() on another system/kernel. This problem may surface if you compile your program
using headers from version_1 of the kernel, and then install another version of the kernel or a
custom kernel that has extended the system call table (on the same system). If we want to improve
the portability then we can avoid this approach or improve this approach. It may or may not be
complex to implement these.

1. Invoke a system call using its name. Pass its name to the kernel as an argument of syscall() or
some other function. Probably may make the invocation of the system call slower. If the name
doesn't match in the kernel then an error can be returned.

2. Create a /proc entry that will return the number of the system call given its name. This number
can then be used to invoke the system call.

These approaches will also remove the dependency from user space header file that contains the
mapping from the system call name to its number. I hope that I made some sense.

Regards,
Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
