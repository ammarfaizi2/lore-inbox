Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286524AbRL0ThV>; Thu, 27 Dec 2001 14:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286532AbRL0ThL>; Thu, 27 Dec 2001 14:37:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:63243 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286530AbRL0ThD>; Thu, 27 Dec 2001 14:37:03 -0500
Message-ID: <3C2B77B9.6143EE1E@zip.com.au>
Date: Thu, 27 Dec 2001 11:34:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Igor Briski <igor.briski@iskon.hr>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3fs corruption problem?
In-Reply-To: <20011227120659.O3081@tsunami.iskon.hr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Briski wrote:
> 
> I've noticed several files missing in last few days and this
> also started happening:
> 
> webmail1 [/space/cwmail/mail/n_z1/f6/jejka74_Pmail_Ixxx_Ixx/2] # ls -la
> total 32
> drwx--S---    2 www-data www-data     4096 Nov 25 22:47 .
> drwx--S---    5 www-data www-data     4096 Dec 26 14:48 ..
> -rw-r--r--    1 www-data www-data     1011 Nov 25 22:47 index.dat
> -rw-r--r--    1 www-data www-data 18446744069414584903 Nov 23 22:25 m_0.dat

There was a truncate problem which could allow this.  It was fixed
in 2.4.17.  Deleting the file and running fsck will clean it up.

Could you please fsck the filesystems, see what it says?

Also, please check the logs for any errors or warnings from the
filesystem and from RAID.

Thanks.

-
