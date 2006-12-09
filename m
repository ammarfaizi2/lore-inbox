Return-Path: <linux-kernel-owner+w=401wt.eu-S937048AbWLIQN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937048AbWLIQN3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 11:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937055AbWLIQN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 11:13:29 -0500
Received: from hempcity.net ([81.171.100.190]:50352 "EHLO hempcity.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937048AbWLIQN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 11:13:28 -0500
Message-ID: <10057.62.194.65.8.1165680804.squirrel@webmail.coolzero.info>
In-Reply-To: <20061209114930.GE10261@atrey.karlin.mff.cuni.cz>
References: <13634.62.194.65.8.1165659510.squirrel@webmail.coolzero.info>
    <20061209105436.GB10261@atrey.karlin.mff.cuni.cz>
    <16096.62.194.65.8.1165661845.squirrel@webmail.coolzero.info>
    <20061209113406.GC10261@atrey.karlin.mff.cuni.cz>
    <19683.62.194.65.8.1165664691.squirrel@webmail.coolzero.info>
    <20061209114930.GE10261@atrey.karlin.mff.cuni.cz>
Date: Sat, 9 Dec 2006 17:13:24 +0100 (CET)
Subject: Re: Ext3 Errors...
From: "Jim van Wel" <jim@coolzero.info>
To: "Jan Kara" <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Reply-To: jim@coolzero.info
User-Agent: SquirrelMail/1.4.8-2.el4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>   Oh, so the machine does not crash or go totally out of memory when this
> happens? At least it seems the filesystem is remounted RO?

Well, that's the most funny thing. It doesn't remount RO, it's still
mounted as RW.

Like here:

/dev/md1 on / type ext3 (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/md0 on /boot type ext3 (rw)
none on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
/proc on /var/named/chroot/proc type none (rw,bind)

So it doesn't mount it to RO. And yes the system is just up and running.
It's a server. So it's on for 24/7. It now only happened for two times
when running the kernel 2.6.19. So it even looks like these messages are
false, because in all logs, I don't see Segfaults anywhere. And there
should be some if the error is really true what is said.

Anyway, I cannot trace back this easily as you can see.

So what can I do to help with these strange messages?

Thanks!
Jim.

>   Hi,
>
>> Well, that's kind of difficult because it looks a little random when he
>> does it, and a interval of three days, but also is maybe random.
>>
>> And the most difficult part is it's only for three seconds, and than
>> it's
>> gone, so making a crontab script every minute might not even notice it?
>   Oh, so the machine does not crash or go totally out of memory when this
> happens? At least it seems the filesystem is remounted RO?
>
> <snip>
>> >> >> Dec  5 23:50:49 kernel: do_get_write_access: OOM for frozen_buffer
>> >> >> Dec  5 23:50:49 kernel: ext3_free_blocks_sb: aborting transaction:
>> >> Out
>> >> >> of
>> >> >> memory in __ext3_journal_get_undo_access
>> >> >> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
>> >> >> ext3_free_blocks_sb:
>> >> >> Out of memory
>> >> >> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
>> >> >> ext3_reserve_inode_write: Readonly filesystem
>> >> >> Dec  5 23:50:50 kernel: EXT3-fs error (device md1) in
>> ext3_truncate:
>> >> Out
>> >> >> of memory
>> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> >> >> ext3_reserve_inode_write: Readonly filesystem
>> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> >> ext3_orphan_del:
>> >> >> Readonly filesystem
>> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> >> >> ext3_reserve_inode_write: Readonly filesystem
>> >> >> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> >> ext3_delete_inode:
>> >> >> Out of memory
>  <snip>
>
> 								Honza
> --
> Jan Kara <jack@suse.cz>
> SuSE CR Labs
>

