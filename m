Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131698AbRBWTMz>; Fri, 23 Feb 2001 14:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131772AbRBWTMo>; Fri, 23 Feb 2001 14:12:44 -0500
Received: from adsl-208-190-202-115.dsl.kscymo.swbell.net ([208.190.202.115]:48262
	"HELO sbox") by vger.kernel.org with SMTP id <S131698AbRBWTM0>;
	Fri, 23 Feb 2001 14:12:26 -0500
Date: Fri, 23 Feb 2001 13:12:05 -0600
From: Ian Wehrman <ian@wehrman.com>
To: mhaque@haque.net, adilger@turbolinux.com, linux-kernel@vger.kernel.org
Subject: Re: EXT2-fs error
Message-ID: <20010223131205.A10434@wehrman.com>
Reply-To: ian@wehrman.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammad A. Haque <mhaque@haque.net> wrote:
> I got the following after compiling/rebooting into 2.4.2 and forcing a
> fsck.
> 
> EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
> #508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
> name_len=0
> EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
> #508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
> name_len=0
> 
> Possibly the result of the 'silent' bug in 2.4.1?

you are not the only one who found this bug. immediately after booting 2.4.2 i
received dozens of these errors, resulting in _major_ filesystem corruption.
after a half hour of fsck'ing i managed to bring the machine back into a usable
state, but there are still many files and directories around the fs that have
the wrong uid/gid associated with them, as well as incorrect file type,
permissions, etc. i'm not using any unusual hardware, and haven't had any
other recent issues like this. let me know if i can provide further information,
or test patches. 

thanks,
ian wehrman 
