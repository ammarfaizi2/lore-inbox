Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283380AbRLIMkb>; Sun, 9 Dec 2001 07:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283381AbRLIMkV>; Sun, 9 Dec 2001 07:40:21 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:33801 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S283380AbRLIMkG>; Sun, 9 Dec 2001 07:40:06 -0500
Message-ID: <3C135B9F.29A15701@namesys.com>
Date: Sun, 09 Dec 2001 15:39:59 +0300
From: "Vladimir V. Saveliev" <vs@namesys.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-64GB-SMP i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Zarochentcev <zam@namesys.com>
CC: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: reiserfs_delete_solid_item [ xxx xxx 0(1) DIR ] not found when FS 
 full?
In-Reply-To: <20011208062921.GA3002@alpha.of.nowhere> <15378.8955.835551.333970@backtop.namesys.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Alexander Zarochentcev wrote:

> Jurriaan on Alpha writes:
>
>  > I was copying some tree and didn't notice my file-system filling up, but
>  > I did notice this on the console (and in the logs):
>  >
>  > Dec 8 07:17:31 alpha sudo: jurriaan : TTY=tty3 ; PWD=/var/spool ; USER=root
>  > ; COMMAND=/bin/cp -ax news testnews Dec 8 07:22:03 alpha kernel: vs-5355:
>  > reiserfs_delete_solid_item: [434934 434961 0(1) DIR] not found<4>vs-5355:
>  > reiserfs_delete_soli d_item: [434933 434961 0(1) DIR] not found<4>vs-5355:
>  > reiserfs_delete_solid_item: [434961 434962 0(1) DIR] not found<4>vs-5355:
>  > reise rfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
>  > reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4 >vs-5355:
>  > reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
>  > reiserfs_delete_solid_item: [434962 434963 0(1) D IR] not found<4>vs-5355:
>  > reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
>  > reiserfs_delete_solid_item: [43496 2 434963 0(1) DIR] not found<4>vs-5355:
>  > reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
>  > reiserfs_delete_sol id_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
>  > reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
>  > reis erfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
>  > reiserfs_delete_solid_it
>  >
>  > Somehow, 'delete' is not what I expect when copying. Is this something
>  > to worry about?
>
> `Delete' is possible when copying. reiserfs_new_inode() fails due to no free
> space and iput() is called on partially created inode. Some items could be
> missing and delete_inode() => delete_solid_item() warns during attempt to
> delete them.
>

This warning is 100% harmless when it appears as result of mkdir which fails due to
lack of disk space.

Thanks,
vs


