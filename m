Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287244AbSASUqU>; Sat, 19 Jan 2002 15:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287287AbSASUqL>; Sat, 19 Jan 2002 15:46:11 -0500
Received: from ns.suse.de ([213.95.15.193]:58130 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287244AbSASUp6>;
	Sat, 19 Jan 2002 15:45:58 -0500
To: Hans-Joachim Baader <hjb@pro-linux.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Usage of filetype
In-Reply-To: <20020119192756.Z3627@mandel.hjb.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Jan 2002 21:45:57 +0100
In-Reply-To: Hans-Joachim Baader's message of "19 Jan 2002 19:27:59 +0100"
Message-ID: <p73adva3w8q.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Joachim Baader <hjb@pro-linux.de> writes:

> in the tune2fs manual I found the ext2 option 'filetype'. A file type seems
> to be an 8 bit number, defined in linux/dirent.h in struct dirent64.
> However, I didn't find any further docs about it, and I don't know any
> userspace tools to read/set it. Could anyone please point me to more info
> (or explain if this feature has any use)?

It sets the d_type field in struct dirent on readdir. See 
/usr/include/dirent.h in glibc for a list of the types. It's useful 
to find out something about a file without reading its inode
(=causing a slow seek of the hard disk). For example it can be used
to optimize find(1) or ls(1). 


-Andi
