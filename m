Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSHSLar>; Mon, 19 Aug 2002 07:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSHSLar>; Mon, 19 Aug 2002 07:30:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23310 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315282AbSHSLaq>; Mon, 19 Aug 2002 07:30:46 -0400
Date: Mon, 19 Aug 2002 12:34:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: reiserfs-dev@namesys.com
Subject: Reiserfs merge error?
Message-ID: <20020819123445.A17471@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just been reading some of the reiserfs code in 2.5.31, and came
across this little gem in fs/reiserfs/super.c:reiserfs_fill_super():

    sbi->s_mount_state = SB_REISERFS_STATE(s);
    sbi->s_mount_state = REISERFS_VALID_FS ;

it looks like a merge error; the reiserfs people should probably take
a look at it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

