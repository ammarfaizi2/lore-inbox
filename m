Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbRGTLoZ>; Fri, 20 Jul 2001 07:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266937AbRGTLoP>; Fri, 20 Jul 2001 07:44:15 -0400
Received: from a1as04-p179.fra.tli.de ([195.252.198.179]:19328 "EHLO
	pc8.trash.bin") by vger.kernel.org with ESMTP id <S266930AbRGTLoI>;
	Fri, 20 Jul 2001 07:44:08 -0400
Date: Fri, 20 Jul 2001 13:42:52 +0200
From: Marc-Jano Knopp <mjk@rbg.informatik.tu-darmstadt.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6: chattr / lsattr does not work on directories anymore!
Message-ID: <20010720134252.A758@rbg.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Since kernel 2.4.6, the commands 'lsattr' and 'chattr' do not work
anymore when applied to directories:

As root:

# mkdir x
# chattr +i x
chattr: Inappropriate ioctl for device while reading flags on x
# lsattr -d x
lsattr: Inappropriate ioctl for device While reading flags on x
#

The error message also appears when I try to get or set any of the
other ext2 flags. I need the ext2 immutable flag to protect some
of the directories on my system against accidental deletion (be it
my fault or a buggy program).

Kernels < 2.2.6 and 2.2.18 work fine.


Best regards,

  Marc-Jano
  

-- 
http://mjk.c64.org/

