Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUC1C2S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 21:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUC1C2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 21:28:18 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:45120 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262060AbUC1C2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 21:28:17 -0500
Message-ID: <4066383F.9090505@blueyonder.co.uk>
Date: Sun, 28 Mar 2004 03:28:15 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc2-mm4
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2004 02:28:16.0450 (UTC) FILETIME=[5394CA20:01C4146C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
 > You'll need to revert signal-race-fix.patch until the various arch guys
 > catch up.
Did that, no change, looks like we have something missing in signal.c 
for x86_64.
   HOSTCC  usr/gen_init_cpio
   CPIO    usr/initramfs_data.cpio
   GZIP    usr/initramfs_data.cpio.gz
   AS      usr/initramfs_data.o
   LD      usr/built-in.o
   CC      arch/x86_64/kernel/process.o
   CC      arch/x86_64/kernel/semaphore.o
   CC      arch/x86_64/kernel/signal.o
arch/x86_64/kernel/signal.c: In function `do_signal':
arch/x86_64/kernel/signal.c:426: warning: passing arg 2 of 
`get_signal_to_deliver' from incompatible pointer type
arch/x86_64/kernel/signal.c:426: error: too few arguments to function 
`get_signal_to_deliver'
make[1]: *** [arch/x86_64/kernel/signal.o] Error 1
make: *** [arch/x86_64/kernel] Error 2
Regards
Sid.

