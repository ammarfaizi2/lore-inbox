Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269731AbRHMCdk>; Sun, 12 Aug 2001 22:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269735AbRHMCdb>; Sun, 12 Aug 2001 22:33:31 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:62224 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S269731AbRHMCdV>; Sun, 12 Aug 2001 22:33:21 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-pre1 unresolved symbols in fat.o/smbfs.o
In-Reply-To: <9l77lm$nbs$1@ns1.clouddancer.com>
In-Reply-To: <Pine.LNX.4.33.0108121735510.1228-100000@penguin.transmeta.com> <E15W5eq-0006Y5-00@the-village.bc.nu> <9l77lm$nbs$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010813023331.A8DEA783EE@mail.clouddancer.com>
Date: Sun, 12 Aug 2001 19:33:31 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>
>On Mon, 13 Aug 2001, Alan Cox wrote:
>>
>> Oops my fault. My kernel/ksyms goes
>>
>> EXPORT_SYMBOL(vfs_unlink);
>> EXPORT_SYMBOL(vfs_rename);
>> EXPORT_SYMBOL(vfs_statfs);
>> EXPORT_SYMBOL(generic_file_llseek);
>> EXPORT_SYMBOL(generic_read_dir);
>> EXPORT_SYMBOL(__pollwait);
>> EXPORT_SYMBOL(poll_freewait);
>>
>> If you edit yours and drop that line in then rebuild from clean all should
>> be well
>
>Hmm.. You should probably also add "no_llseek" there..
>
>		Linus


Seems to need it:

/usr/src/linux }make  modules_install  >/dev/null

depmod: *** Unresolved symbols in /lib/modules/2.4.9-pre1/kernel/drivers/media/video/tvmixer.o
depmod:         no_llseek
depmod: *** Unresolved symbols in /lib/modules/2.4.9-pre1/kernel/drivers/media/video/videodev.o
depmod:         no_llseek
depmod: *** Unresolved symbols in /lib/modules/2.4.9-pre1/kernel/drivers/sound/sound.o
depmod:         no_llseek
depmod: *** Unresolved symbols in /lib/modules/2.4.9-pre1/kernel/fs/fat/fat.o
depmod:         generic_file_llseek




-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."

