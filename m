Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbTDGVAO (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbTDGVAO (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:00:14 -0400
Received: from mars.mj.nl ([81.91.1.49]:8911 "HELO mars.mj.nl")
	by vger.kernel.org with SMTP id S263663AbTDGVAO (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:00:14 -0400
Subject: Re: [2.5.66] APM loses track of batteries
From: Thomas Hood <jdthood@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Cc: DevilKin <devilkin-lkml@blindguardian.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049749907.1801.16.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Apr 2003 23:11:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With two batteries inserted you see:
> devilkin@laptop:~$ cat /proc/apm
> 1.16ac 1.2 0x03 0x01 0xff 0x10 -1% -1 ?

I think the problem is that your firmware doesn't know how
to report battery status when two batteries are installed.
When you momentarily remove one of the two batteries,
the firmware is momentarily able to report the state of the
remaining battery.

My guess is that the only solution is to use ACPI.

-- 
Thomas Hood <jdthood@yahoo.co.uk>

