Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbVIVNR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbVIVNR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVIVNR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:17:59 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:51115 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030322AbVIVNR5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:17:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MDX1hudXGTOM3teWqd86FFbXMcPdFzLM1vlepGOwral4XaS8T1xkhdT5fxXXM8GIRLFZZJ+oq1LZCuSUPSfMJwMzKmTJo2KyGpvC2qKC0WxmbDM9qDz2U24/IQThhZXILXpXQWP2XOJUkKyhrFRDC8VyjZnzW8D/tVTL+BBT+88=
Message-ID: <28f73412050922061735b157a@mail.gmail.com>
Date: Thu, 22 Sep 2005 13:17:50 +0000
From: Andy Fong <boringuy@gmail.com>
Reply-To: Andy Fong <boringuy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: major oops resier4 on 2.6.14-rc1-mm1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using reiser4 on a SATA drive and got a major oops after
upgrading to 2.6.14-rc1-mm1. The whole system hangs and all changes on
FS are lost after reboot. So, I lost the log file too.

Then it kind of happened again but this time not completely hang. It
reported a fatal operation at block_alloc.c: 140. in dmesg.
This is from my memory because I try to go back to my old kernel
2.6.12 but the fs seems to be corrupted and I
got a kernel panic. However, the new 2.6.14-rc1-mm1 kernel will still
boot up. So, I did a fsck.reiser4 --build-fs.
After that, none of the kernel can detect the partition and I got
kernel panic. I just created a liveCD and doing fsck.reiser4 again and
hope that it will work better this time. So, I don't have any trace or
log file but this is a serious bug.

I notice there is a 2.6.14-rc2-mm1 which some reiser4 fixes in the log
file. I wonder if those fixes is related to this bug.
I just want to make sure this get fix soon. Also, if anyone have idea
on how to recover the partition, please let me know.

Since I am not on the list yet, please make sure you cc the reply to
my email. Thank you.
