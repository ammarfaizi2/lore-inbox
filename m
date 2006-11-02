Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752748AbWKBIwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbWKBIwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbWKBIwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:52:50 -0500
Received: from nz-out-0102.google.com ([64.233.162.199]:17358 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752748AbWKBIwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:52:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oa89nfP5WbAZ/5c2rRxGXBncmxrTd3tqX+n8+8c50QfnK1Vb1Pky7WYypgWtHNep1ILEy5Xw8GU8u3SdL6TeS7vXqWYTarq5xG4/8yvgXb1Enrz4ZENOkNNWUgToUS45C7Ifko9LTdPfDlbH0eh18Wy6saHkqBDF5AanmyimPXk=
Message-ID: <b3c691930611020052k4cee7582lf58942c1b1151916@mail.gmail.com>
Date: Thu, 2 Nov 2006 16:52:48 +0800
From: "FENG ZHOU" <zhfeng.osprey@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to optimize system time for such case?
In-Reply-To: <b3c691930611020047p4a59206aj3fc3060e2f74e426@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b3c691930611020047p4a59206aj3fc3060e2f74e426@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all
I am optimizing a compiler and I believe there is a bug in such
compile. Currently, I have a test case, which is a scientific
application, has a lot of system time. This is weird, because this
case does not have many system calls. Meanwhile, compiled at another
option, I found all the "system time" are gone! So, I assume there is
some problem in the first one (though both binary produce correct
result). I used some performance tuning tool and found the hottest
address for CPU privilege level change event is: 0xa000000100001a70.
This address is not in code or data segment. Now, I am kinda stuck
here. My question is: how to find what this address is? Or find out
what is the cause of the "system time"? Thanks in advance.

PS: the platform is Itanium 2.
-Feng
