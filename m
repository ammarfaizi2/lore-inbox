Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130476AbQLHSDj>; Fri, 8 Dec 2000 13:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131696AbQLHSD3>; Fri, 8 Dec 2000 13:03:29 -0500
Received: from vena.lwn.net ([206.168.112.25]:265 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S130476AbQLHSDU>;
	Fri, 8 Dec 2000 13:03:20 -0500
Message-ID: <20001208173246.25203.qmail@eklektix.com>
To: linux-kernel@vger.kernel.org
Subject: On running user mode helpers
From: Jonathan Corbet <corbet-lk@lwn.net>
Date: Fri, 08 Dec 2000 10:32:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see we have a new "call_usermodehelper" routine now.  It looks like the
end result is similer to exec_usermodehelper, except that you no longer
need to mess with creating kernel threads yourself.

Is call_usermodehelper now the officially blessed way for kernel code to
run something in user space?  Perhaps exec_usermodehelper should become
private to kmod.c?

I also see that call_usermodehelper will call do_exit() if the exec fails,
while the path taken in request_module does not do that.  Can both be
right? 

Thanks,

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
