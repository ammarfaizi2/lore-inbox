Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285940AbRLYUmR>; Tue, 25 Dec 2001 15:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285881AbRLYUmH>; Tue, 25 Dec 2001 15:42:07 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:54760 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S285879AbRLYUl7>;
	Tue, 25 Dec 2001 15:41:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: "James Stevenson" <mistral@stev.org>, <linux-kernel@vger.kernel.org>,
        <netfilter-devel@lists.samba.org>
Subject: Re: file names ?
Date: Tue, 25 Dec 2001 12:41:14 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <000701c18d82$57158ea0$0801a8c0@Stev.org>
In-Reply-To: <000701c18d82$57158ea0$0801a8c0@Stev.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16IyNw-0003UO-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 25, 2001 12:25, James Stevenson wrote:
> a small example is a smallish ext2 / filesystem
> and the rest being a fat filesystem to that
> it can be accessed from both windows and linux.
> and there is not enough space on the ext2 to compile a kernel anymore.

Case-insensitivity is not your only problem. 'ln -s' is used multiple times 
during the kernel build process, I'd like to see a FAT filesystem try to 
handle that. I haven't checked, but the compile might also depend on the 
executable bit actually working, and being able to rename and unlink files in 
use. Even with filenames that do not collide in a case-insensitive namespace, 
the build will fail. 

The kernel compile requires a POSIX filesystem, which is a completely sane 
demand. I'd go as far as saying that all 'real' filesystems are POSIX 
compliant, and that non-POSIX filesystems should only be used for simple data 
file storage. 

-Ryan
