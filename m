Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264946AbUGIPAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbUGIPAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbUGIPAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 11:00:55 -0400
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:28608 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S264946AbUGIPAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 11:00:53 -0400
Message-ID: <40EEB322.40002@moving-picture.com>
Date: Fri, 09 Jul 2004 16:00:50 +0100
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Moestl <moestl@ibr.cs.tu-bs.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: umount() and NFS races in 2.4.26
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Moestl:
 >after deploying an SMP machine at work, we started to experience Oopses
 >in file-system related code relatively frequently. Investigation
 >revealed that they were caused by references using junk pointers from
 >freed super blocks via dangling inodes from unmounted file systems;
 >Oopses would always be preceded by the warning
 > VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a 
nice day...
 >on an unmount (unmount activity is high on this machine due to heavy 
 >use of the automounter).

Are you using the latest autofs4 kernel patches?

I had a similar problem - see the thread at:

http://marc.theaimsgroup.com/?l=linux-nfs&m=108515468003933&w=2

The latest autofs4 patches fixed it for me - available from:

http://www.kernel.org/pub/linux/daemons/autofs/v4

James Pearson
