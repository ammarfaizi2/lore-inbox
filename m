Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVDDJmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDDJmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 05:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVDDJmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 05:42:10 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:20654 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261198AbVDDJkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 05:40:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=o/TGQiSk1ZYkXLYOLC9elBjwiBTyWBEalyEMHYnZR4gvXV8iJSV1LFP8b8PF0LOHWfMb49dx8/ol5WVR21kMxR91/zqCUoVxItO73tLB2Pza70H3ALumWcqIb0iy5NYPSm9YfMNXTFZlv45rBHxWD1kufLab/8aqq5atU62CPDs=
Message-ID: <c0310912050404024062a183b8@mail.gmail.com>
Date: Mon, 4 Apr 2005 18:40:22 +0900
From: Piotr Muszynski <piotru@gmail.com>
Reply-To: Piotr Muszynski <piotru@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: module for controlling kprobes with /proc
Cc: Joel.Becker@oracle.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
>> I have programmed a universal module to register/remove kprobes handlers
>> by interacting with /proc with simple commands.
>
>
>	Looking at your code, I'm thinking you could really use
>configfs.  With configfs, kernelspace objects are created and controlled
>via regular filesystem operations.  Instead of echoing a cryptic line to
>your proc file, a user could instead create objects in a directory:
>
>To insert a handler:
>	cd /config/kprobes
>	mkdir myhandler
>	cd myhandler
>	echo 0x12345678 > handler_address
>	echo 0x87654321 > breakpoint_address
>	echo post > when
>
>To remove one:
>	cd /config/kprobes
>	rmdir myhandler
>
>	If this interests you at all, see
>http://oss.oracle.com/projects/ocfs2/src/trunk/fs/configfs/,
>specifically configfs.txt and configfs_example.c.  I'm going to be
>submitting this for mainline inclusion soon.

Joel,  thank you very much - this looks like a Good Idea. I am going
to try configfs  as soon as my schedule permits.
(Will be grateful for any directions, as I'm new in kernelspace :-))

Piotr
PS Hope you don't mind me quoting your message here.
