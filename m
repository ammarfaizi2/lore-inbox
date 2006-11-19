Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756590AbWKSMAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590AbWKSMAi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 07:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756591AbWKSMAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 07:00:37 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:25736 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S1756590AbWKSMAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 07:00:37 -0500
Date: Sun, 19 Nov 2006 13:00:01 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org
Subject: uml fails to compile due to missing offsetof
Message-ID: <20061119120000.GA4926@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I fail to see how arch/um/sys-i386/user-offsets.c can compile since
offsetof() was declared __KERNEL__ only in include/linux/stddef.h.
Does it work for anyone else? If so, is linux/stddef.h or
/usr/include/linux/stddef.h used during compilation?
The x86_64 variant looks weird as well, linux/stddef.h is appearently
included via some other headers.
