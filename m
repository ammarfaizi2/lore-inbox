Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVFLKOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVFLKOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 06:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVFLKOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 06:14:50 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:41992 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261319AbVFLKOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 06:14:48 -0400
Date: Sun, 12 Jun 2005 12:14:50 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: static struct initialization question
Message-Id: <20050612121450.5fc277a6.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I need to statically intialize a structure which looks like:

struct items
{
	int first;
	int *others;
}

Where "others" points to a 0-terminated list of ints.

I plan to initialize it that way:

static struct items s = {
	.first = 1;
	.others = (int[]) {
		2,
		3,
		0
	}
};

It works fine here with gcc 3.3.4. Question is, is this style allowed in
the kernel? I think it's C99 standard. I only found such constructs in
arch/ppc/syslib/mpc*.c and sound/usb/usbquirks.h.

Thanks,
-- 
Jean Delvare
