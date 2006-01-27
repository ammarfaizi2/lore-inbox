Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWA0UVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWA0UVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWA0UVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:21:43 -0500
Received: from dns.toxicfilms.tv ([150.254.220.184]:50894 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S1161010AbWA0UVm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:21:42 -0500
X-Spam-Report: SA TESTS
 -1.7 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -2.3 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
  0.4 AWL                    AWL: From: address is in the auto white-list
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(62.21.10.43):SA:0(-3.6/2.5):. Processed in 7.981131 secs Process 18613)
Date: Fri, 27 Jan 2006 21:21:47 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <166928002.20060127212147@dns.toxicfilms.tv>
To: "Vladimir V. Saveliev" <vs@namesys.com>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.6.15 reiserfs bugs that cause the system to hang and increase load sistematically
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vladimir,

Friday, January 27, 2006, 2:26:48 PM, you wrote:

> On Thu, 2006-01-26 at 21:10 +0100, Maciej Soltysiak wrote:
>> Hello!
>> 
>> I just hit a problem with reiserfs. While working this popped on the console:
>> ReiserFS: sdb2: warning: vs-13060: reiserfs_update_sd: stat data of object [2497 4756 0x0 SD] (nlink == 2) not found (pos 1)
>> ReiserFS: sdb2: warning: zam-7002:reiserfs_add_entry: "reiserfs_find_entry" has returned unexpected value (3)
>> REISERFS: panic (device sdb2): vs-7050: new entry is found, new inode == 0
>> 

> rename encountered "hidden" name when it should not be there.
> the attached patch should make reiserfs to not panic but return -EIO.
Ok, I'll apply that patch and be on the lookout for this warning.

> It would be interesting to know how did you manage to create hidden
> names.
Well on this partition hidden names could have been created either by:
a) bash, and mc with files like .bash_history, etc.. (all standard stuff)
b) courier-imap which creates directories for IMAP folders, like:
   .My Folder
   .Sent
   .Trash

For now, I have no clues about it.

> you should reiserfsck /dev/sdb2
Sure thing.

Thanks a lot.
Maciej


