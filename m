Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbUDORrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbUDORpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:45:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:26038 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263156AbUDORmN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:13 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509132396@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:53 -0700
Message-Id: <10820509131756@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.15, 2004/04/09 11:50:34-07:00, hannal@us.ibm.com

[PATCH] fix sysfs class support to fs/coda/psdev.c

--On Friday, April 09, 2004 12:02:19 AM +0200 Marcel Holtmann <marcel@holtmann.org> wrote:
>> +static struct class_simple coda_psdev_class;
>
> I think coda_psdev_class must be a pointer.
>
> Regards
>
> Marcel


Doh! I tested on one system and fixed this there. Then accidentally mailed out the
original. Sorry about that. Here is a patch to fix it:


 fs/coda/psdev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/fs/coda/psdev.c b/fs/coda/psdev.c
--- a/fs/coda/psdev.c	Thu Apr 15 10:20:22 2004
+++ b/fs/coda/psdev.c	Thu Apr 15 10:20:22 2004
@@ -62,7 +62,7 @@
 
 
 struct venus_comm coda_comms[MAX_CODADEVS];
-static struct class_simple coda_psdev_class;
+static struct class_simple *coda_psdev_class;
 
 /*
  * Device operations

