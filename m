Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268723AbTBZLnX>; Wed, 26 Feb 2003 06:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268724AbTBZLnW>; Wed, 26 Feb 2003 06:43:22 -0500
Received: from webmail14.rediffmail.com ([203.199.83.24]:58240 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S268723AbTBZLmP>;
	Wed, 26 Feb 2003 06:42:15 -0500
Date: 26 Feb 2003 11:51:38 -0000
Message-ID: <20030226115138.12524.qmail@webmail14.rediffmail.com>
MIME-Version: 1.0
From: "Diksha B Bhoomi" <dikshabhoomi@rediffmail.com>
Reply-To: "Diksha B Bhoomi" <dikshabhoomi@rediffmail.com>
To: linux-kernel@vger.kernel.org
Cc: "Herman Oosthuysen" <Herman@WirelessNetworksInc.com>
Subject: Re: Re: Writing new filesystem
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks

I tried that as well butnothing much seems to happing. I searched 
the fs/Makefile for "ext2" It comes in the All_SUB_DIRS variable 
setting. I already have added myfs entry for this varible. That is 
the reason why it went to fs/myfs in make dep. But that does not 
solve the purpose.

I once again tell you what am I doing.

I created a directory as fs/myromfs. I copioed into this folder 
everything that was present in fs/romfs. Then I changed the 
romfs_fs.h to myromfs_fs.h with all MACROS changed appropriatly. I 
included this file in namei.c. I even made changes to all ROMxxx 
to MYxxx in inode.c file.
I changed the Makefile for myromfs as well.

Now my problem is  how do i compile it.

I tried make from myromfs dir. but it gave error as TOPDIR not 
set. So in the Makefile of myromfs I added a entry as 
$TOPDIR=/usr/src/linux/
That started the compilation but proper gcc params were not set so 
gcc failed. That made me confirmed that $TOPDIR must be 
comented.

Now I tried to compile from fs dir but again same mesage 
appared.

So I went one level up and tried to do make at /usr/src/linux
This is I suppose making kernel. It did work but with out much 
results.

I then went on to make dep here only.
This time it did go to fs/myromfs and displayed the message
'leaving the dir /usr/src/linux/fs/myromfs'


Now what should I do.

In otherwords, How do i create the new filesysytem using the given 
src and makefiles?

Thanks a lot for your Time and Space.

Diksha


Atta Dipa Bhava
