Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVEEMlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVEEMlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVEEMlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:41:25 -0400
Received: from agf.customers.acn.gr ([213.5.17.156]:42217 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP id S262087AbVEEMlK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:41:10 -0400
Message-ID: <001d01c5516f$b5f37c20$0101010a@dioxide>
From: "linux" <kernel@wired-net.gr>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20050425165826.GB11938@redhat.com> <20050429040104.GB9900@redhat.com> <1114815509.18352.200.camel@ibm-c.pdx.osdl.net> <200504300509.24887.phillips@istop.com> <1115295930.1988.229.camel@sisko.sctweedie.blueyonder.co.uk>
Subject: copy_to_user question
Date: Thu, 5 May 2005 15:40:17 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, i have a question about copy_to_user function.
I have a module which declares a struct test { int size; char *name; int
value_add };
I like to transfer that struct to userspace through an ioctl command like
that:

struct test test_struct;
memset(&test_struct,0,sizeof(test_struct);
test_struct.size= 100;
test_struct.name = "test name";
test_struct.value_add = 2;
copy_to_user((void __user *)arg,&test_struct,sizeof(struct test));


When i use the ioctl command in user-space and try to get the name item a
segfault occurs.Can u tell me why??
Can we transfer from kernel-space to user-space pointers like the one i use
or this is a fault approach???


Best regards,
Chris.


