Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270778AbTGNT6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270758AbTGNT4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:56:52 -0400
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:61057 "EHLO
	athlon.cichlid.com") by vger.kernel.org with ESMTP id S270755AbTGNT4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:56:14 -0400
Date: Mon, 14 Jul 2003 13:11:00 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200307142011.h6EKB0o29221@athlon.cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/fs/file-max broken in 2.4.22-pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy wrote:

>On Sun, Jul 13, 2003 at 03:31:54PM -0700, Andrew Burgess wrote:
> 
>> root@athlon:/root # echo 60000 > /proc/sys/fs/file-max
>> root@athlon:/root # cc file-max.c 
>> root@athlon:/root # a.out
>> Too many open files
>> opened 1021 files
>> root@athlon:/root # uname -a
>> Linux athlon 2.4.22-pre5 #2 SMP Sun Jul 13 12:38:04 PDT 2003 i686 unknown
>
>ulimit -n ?

It works without ulimit on earlier kernels but sure enough this
fixed it on 22-pre5. Thank you!

I assume ignoring ulimit was a bug that is now fixed?

