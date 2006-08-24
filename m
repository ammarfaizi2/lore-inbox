Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWHXSBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWHXSBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWHXSBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:01:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:19871 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751655AbWHXSBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:01:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=K3ur4BZPbZ4MYRlNQ3BS2GuOeW+4rJWu5hXdBkVws++rLyBl8FgK8AEFuaRANK6UXvc1+AUh/K+GpSaiXcjIjNqDvpqzXBaCWo8/RxFd2FRuuyRgGfFlsjUHuUI7vZ03VAYa54s49THGroeeL7JFBpmOt5fMmNISOcb+BfQ3w94=
Message-ID: <3f396c130608241101u64358ddfhfc5f1ae3cde4f3ee@mail.gmail.com>
Date: Thu, 24 Aug 2006 20:01:46 +0200
From: "febo@delenda.net" <febo@delenda.net>
To: linux-kernel@vger.kernel.org
Subject: kernel panic
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: dd103487d4014cbb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running a stock FC5 kernel with a P4 and HT enabled..
After 1 month uptime with no problems I get this out of the blue. The
system practically hanged, only ICMP was working, had to reboot.Could
it be related to cpuspeed or amavisd (the latter seems unlikely)... ?

Aug 24 12:43:07 mail kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000051
Aug 24 12:43:07 mail kernel:  printing eip:
Aug 24 12:43:07 mail kernel: c01467fb
Aug 24 12:43:07 mail kernel: *pde = 03162001
Aug 24 12:43:07 mail kernel: Oops: 0000 [#1]
Aug 24 12:43:07 mail kernel: SMP
Aug 24 12:43:07 mail kernel: last sysfs file:
/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
Aug 24 12:43:07 mail kernel: Modules linked [..]
Aug 24 12:43:07 mail kernel: CPU:    0
Aug 24 12:43:07 mail kernel: EIP:    0060:[<c01467fb>]    Not tainted VLI
Aug 24 12:43:07 mail kernel: EFLAGS: 00210002   (2.6.15-1.2054_FC5smp #1)
[..]
Aug 24 12:43:07 mail kernel: Process amavisd (pid: 22608,
threadinfo=e9358000 task=f7d1ba30)
[..]
Aug 24 12:43:07 mail kernel: Call Trace:
Aug 24 12:43:07 mail kernel:  [<c0163762>]
__find_get_block_slow+0x38/0x114     [<c016422c>]
[..]
Aug 24 12:43:08 mail kernel: Code: 89 d8 5a 5b 5e 5f 5d c3 57 56 53 89
c3 89 d6 8d 78 10 89 f8 e8 82 ba 1a 00 83 c3 04 89 f2 89 d8 e8 53 cb
08 00 89 c3 85 c0 74 10 <8b> 00 89 da f6 c4 40 74 03 8b 53 0c f0 ff 42
04 89 f8 e8 ef b9
Aug 24 12:43:08 mail kernel: Continuing in 120 seconds... Continuing
in 1 seconds.
Aug 24 12:43:08 mail kernel:  <3>Debug: sleeping function called from invalid
 [..]
