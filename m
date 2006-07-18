Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWGRCwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWGRCwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 22:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWGRCwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 22:52:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:55743 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751110AbWGRCwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 22:52:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dtq1PCfBNCqUE/6O/ypyOuwiCFMmSdIzjJsWXhJKcbnp5DxB8S0osDfRH+JP2M/ir/M4OjqAnvGoFGzP8D7WSZiS1pezVjcYJmV/5pJgIgGAKjJELfkrbrM9R5UF0KoPAuPFZRZ/e9nT5FHLXMPC23KRfKKYmq+4sD1MOCSbPsE=
Message-ID: <a63d67fe0607171952o539a6a29te75ef332bcdbba22@mail.gmail.com>
Date: Mon, 17 Jul 2006 19:52:16 -0700
From: "Dan Carpenter" <error27@gmail.com>
To: ebiederm@xmission.com
Subject: shut down from CPU 0 [regression]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6660316cb7a1a2c59a73a52870490c0f782f45c1

Even though you should be able to call ACPI power down from either
CPU, I've seen some BIOSes that implement it wrong.  That's why the
code was there.
For example: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=189052

regards,
dan carpenter
