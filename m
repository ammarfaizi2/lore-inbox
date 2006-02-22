Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWBVRAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWBVRAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWBVRAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:00:36 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:48208 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750804AbWBVRAf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:00:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KCJSGjt9P8XVwrvbW9ZOoj2ii3VHcq0XO0DzWh/aaNx5fymeMNhA8cqiN7OZmJakxVUMyCAgAdcFkgTONTlsfOXzlbqWHWkVGChSa0XbA0kEwa/HN1laX/PLYt/brFUoinKZ5H0Bk7Gi4PDHU7NeuYKt9PHkhZpHNdfNGFZs8UM=
Message-ID: <60bb95410602220900n440564d7xb459d47c8ca30997@mail.gmail.com>
Date: Thu, 23 Feb 2006 01:00:34 +0800
From: "James Yu" <cyu021@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel thread removal
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I remove a kernel thread in kernel mode ?
I write a C-function in one of the Linux source files and create a
kernel thread by invoking kernel_thread() to run the function, like:
"kernel_thread(a1, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);"
Function a1 simply invokes printk() to output some message on console.
I invoke do_exit(0); at the end of a1, but a1's task_struct still
exists in in task_struct list after its execution.
How do I remove it a1's task_struct upon its completion? I thought
explicitly invoke do_exit() ensures the removal of task_struct?
