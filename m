Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268936AbRG0TWI>; Fri, 27 Jul 2001 15:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268934AbRG0TVt>; Fri, 27 Jul 2001 15:21:49 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:48909 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268932AbRG0TVj>; Fri, 27 Jul 2001 15:21:39 -0400
Message-ID: <3B61BF0C.ABA728F0@namesys.com>
Date: Fri, 27 Jul 2001 23:20:44 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Dustin Byford <dustin@firein.net>
CC: Joshua Schmidlkofer <menion@srci.iwpsd.org>, linux-kernel@vger.kernel.org,
        Edward Shushkin <edward@mail.infotel.ru>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q9Bw-0005q5-00@the-village.bc.nu> <0107270926070B.06707@widmers.oce.srci.oce.int> <3B618CF2.5C105903@namesys.com> <3B61AE96.5030909@firein.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Dustin Byford wrote:

> Also, one purely cosmetic patch to rc.sysinit if you want:
> --- rc.sysinit.orig Fri Jul 27 13:06:58 2001
> +++ rc.sysinit Fri Jul 27 13:38:25 2001
> @@ -211,7 +211,8 @@
> 
> _RUN_QUOTACHECK=0
> ROOTFSTYPE=`grep " / " /proc/mounts | awk '{ print $3 }'`
> -if [ -z "$fastboot" -a "$ROOTFSTYPE" != "nfs" ]; then
> +if [ -z "$fastboot" -a "$ROOTFSTYPE" != "nfs" \
> + -a "$ROOTFSTYPE" != "reiserfs" ]; then
> 
> STRING=$"Checking root filesystem"
> echo $STRING


Yes, this patch is much needed.  Edward, put it on our website in an appropriate location.

Hans
