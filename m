Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130432AbRC0B7U>; Mon, 26 Mar 2001 20:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130433AbRC0B7K>; Mon, 26 Mar 2001 20:59:10 -0500
Received: from smtp1.legato.com ([137.69.200.1]:38870 "EHLO smtp1.legato.com")
	by vger.kernel.org with ESMTP id <S130432AbRC0B6t>;
	Mon, 26 Mar 2001 20:58:49 -0500
Message-ID: <019501c0b661$1de195a0$5c044589@legato.com>
From: "David E. Weekly" <dweekly@legato.com>
To: <linux-kernel@vger.kernel.org>
Subject: "mount -o loop" lockup issue
Date: Mon, 26 Mar 2001 17:56:19 -0800
Organization: Legato Systems, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-SMTP-HELO: mail.legato.com
X-SMTP-MAIL-FROM: dweekly@legato.com
X-SMTP-RCPT-TO: linux-kernel@vger.kernel.org
X-SMTP-PEER-INFO: mail.legato.com [137.69.1.58]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux 2.4.2, running a "mount -o loop" on a file properly created with
"dd if=/dev/zero of=/path/to/my/file.img count=1024" seems to decide to
freeze up my shell (not my system). An strace showed the lockup happening at
the actual system "mount()" call, which never returns.

Since mount() is in glibc, it might be relevant to note that I'm running
Mandrake's glibc 2.1.3-16mdk. I compiled the kernel with a gcc of 2.95.3
[1991030] (although oddly enough this binary seems to have come with the
gcc-2.95.2 RPM and installed itself as /usr/bin/gcc-2.95.2) and binutils
2.10.0.24-4mdk.

I'm very sorry to post to this list, but several people independantly told
me that there was a loopback mountpoint deadlocking issue with 2.4.2 and
that I should check here. Of course, this could be a completely retarded
system configuration issue, in which case please shut me up and I'll go away
quietly. But if it is an issue with a known resolution I'd love to hear it -
I wasn't able to find resolution on the web or with several rather
knowledgeable people.

-david weekly [dweekly@legato.com]


