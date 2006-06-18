Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWFRK4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWFRK4c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 06:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWFRK4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 06:56:31 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:51093 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751132AbWFRK4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 06:56:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q+gmlQMNtYGadwAIHmopy5V1pFbxgHy5P/gsxbr9rQrQY1IAI2vOV+XZqOoNKOcQFNF2VvbUDMLPWV4zzexOLqcYJbiSvcw1hQObwjMCqKs/0O6vo+F01RtV/6CBfmUg70tk7aSzDApyQ/zBEXbX0kFESRFak8yPus8F1eUyg+g=
Message-ID: <32124b660606180356k3ebf7791h40a979b40253210d@mail.gmail.com>
Date: Sun, 18 Jun 2006 12:56:30 +0200
From: "Ojciec Rydzyk" <69rydzyk69@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: smp problems
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
There is a bug (I suppose) in file linux/boot/i386/kernel/mpparse.c. I
have laptop Amilo L 7300 and during the kernel boot, I get:
SMP mptable: bad table version
BIOS bug, MP table errors detectd!...

And I just even have one processor. I had to remove kernel options
connected with lapic (added previously to kernel command line).
Some time ago Alan Cox said:

"No actually its our bug. Some BIOSes contain template SMP tables which have
intentionally incomplete data and no checksum. This is used by the BIOS to
generate a real table if SMP is present.

We should not be reporting a wrongly checksummed SMP table we should be
skipping it silently. This used to be right in 2.0 but someone has obviously
elevated debugging code too far since.

Alan"
(adapted from http://www.redhat.com/archives/rhl-beta-list/2006-March/msg01144.html)

So I think it should be fixed :). Thanks,
Greetings,
Jacek Jablonski
