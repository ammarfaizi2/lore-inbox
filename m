Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTI3ANf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 20:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTI3ANf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 20:13:35 -0400
Received: from mail3.efi.com ([192.68.228.90]:19217 "EHLO
	fcexgw03.efi.internal") by vger.kernel.org with ESMTP
	id S263057AbTI3ANe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 20:13:34 -0400
Subject: get into sleep and release the lock in an atomic operation
From: Kallol Biswas <kallol@efi.com>
Reply-To: kallol@efi.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: EFI
Message-Id: <1064881043.8221.21.camel@wskallol>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 29 Sep 2003 17:17:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the few lines of code:

spinlock()

if (num == 0) {
  sleep and release the spinlock in an atomic operation.
}

In the OS like HP-UX there was a sleep lock concept, the
code would look like:

get_sleeplock()

if (num== 0) {
   sleep and release the lock
}

Is there any primitive that implements this kind of spinlock and
sleep in linux?  I could not find it.
I know it can be implemented.


Kallol

