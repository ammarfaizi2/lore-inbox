Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbREHOyT>; Tue, 8 May 2001 10:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132701AbREHOyK>; Tue, 8 May 2001 10:54:10 -0400
Received: from relay.freedom.net ([207.107.115.209]:22792 "HELO
	relay.freedom.net") by vger.kernel.org with SMTP id <S132655AbREHOxt>;
	Tue, 8 May 2001 10:53:49 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQG4AdRjZ3gM1vhGeSymxa22X31kGzFZFLNRf7U15ekGFbQbUyXzXD8n
Date: Tue, 08 May 2001 08:53:18 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: "Hawthorne, Jim J SSI-ISEA" <Jim.J.Hawthorne@is.shell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: write to dvd ram
In-Reply-To: <91FD33983070D21188A10008C728176C09421202@LDMS6003>
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010508145400Z132655-406+505@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks Jim.  Now at least I have a way.

But I caution others that Linux modifies the UDF filesystem somehow, so that Winders can no longer understand it.  I nearly lost all my music & photo archives to this.  And attempts to rm or mv on a DVDRAM with UDF cause it to segfault & jam up.  There doesn't seem to be an answer to this.  (yes, I have written to the developer of cddriver; no response at all after two weeks)  UDF2 is just nonfunctional in Linux and I don't know why.

To recap: running Panasonic LF-D101 DVDRAM drive on SCSI (AHA2940) and
getting segfaults.  On-disk format is UDF2.0, as 2.1 won't mount.

Mount, ls, umount, mount, ls, umount, etc - no problem except filestructure is now no longer available to Winders. (CAUTION! Save data using Linux for recovery in Winders)

Mount, cp <20Mfile>, umount, mount, ls, (20Mfile), umount, mount, ls, (20Mfile),
rpm -q 20Mfile, umount, etc - no problem except filestructure no longer available to Winders.

Mount, rm <20Mfile>, Segmentation Fault, umount, (device busy), umount, (device busy), etc.  Reboot without reset and bootup hangs at Running Linuxconf hooks. Reset & system boots fine.  Mount, ls, (no files), umount, mount, ls, (no files), umount, etc.

Running RedHat Wolverine with HelixGnome & Nautilus.
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914

Keywords: DVDRAM DVD-RAM LF-D101 LFD101 cdrecord


The log is:
Apr 15 20:58:27 hydra kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29) Mounting
volume 'UDF Volume', timestamp 2001/03/02 11:55 (1e98)
Apr 15 20:59:31 hydra kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29) Mounting
volume 'UDF Volume', timestamp 2001/03/02 11:55 (1e98)
Apr 15 20:59:50 hydra last message repeated 3 times
Apr 15 21:00:17 hydra mon[1258]: failure for servers http 987390017 localhost
Apr 15 21:01:11 hydra kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29) Mounting
volume 'UDF Volume', timestamp 2001/03/02 11:55 (1e98)
Apr 15 21:03:25 hydra last message repeated 2 times
Apr 15 21:03:40 hydra kernel: kernel BUG at inode.c:890!
Apr 15 21:03:40 hydra kernel: invalid operand: 0000
Apr 15 21:03:40 hydra kernel: CPU:    0
Apr 15 21:03:40 hydra kernel: EIP:    0010:[iput_free+216/352]
Apr 15 21:03:40 hydra kernel: EIP:    0010:[<c01461c8>]
Apr 15 21:03:40 hydra kernel: EFLAGS: 00010286
Apr 15 21:03:40 hydra kernel: eax: 0000001b   ebx: cb1ad640   ecx: 00000004
edx: c5508840
Apr 15 21:03:40 hydra kernel: esi: c0319560   edi: cb4f2740   ebp: bffff678 esp:
c9d5ff20
Apr 15 21:03:40 hydra kernel: ds: 0018   es: 0018   ss: 0018
Apr 15 21:03:40 hydra kernel: Process rm (pid: 2254, stackpage=c9d5f000)
Apr 15 21:03:40 hydra kernel: Stack: c02a1610 c02a16f3 0000037a 00000000
00000012 c3920000 cffb3560 cb4f2740
Apr 15 21:03:40 hydra kernel:        cb1ad640 c0144a3c cb1ad640 00000184
fffffff0 c39229c0 cb4f2740 00000000
Apr 15 21:03:40 hydra kernel:        c39229c0 c013e31c cb4f2740 cfc83d40
c9d5ff9c 00000000 ffffffeb cb4f2740
Apr 15 21:03:40 hydra kernel: Call Trace: [error_table+39488/42452]
[error_table+39715/42452] [d_delete+76/112] [vfs_unlink+316/368]
[sys_unlink+150/272] [do_page_fault+0/1088] [system_call+51/56]
Apr 15 21:03:40 hydra kernel: Call Trace: [<c02a1610>] [<c02a16f3>]
[<c0144a3c>] [<c013e31c>] [<c013e3e6>] [<c0112de0>] [<c0108ffb>]
Apr 15 21:03:40 hydra kernel:
Apr 15 21:03:40 hydra kernel: Code: 0f 0b 83 c4 0c eb 69 90 39 1b 74 3c f6 83 f8 00 00 00 07 75
Apr 15 21:04:18 hydra mon[1258]: failure for servers http 987390258 localhost


ver_linux
Linux hydra.darkmatter.com 2.4.2-0.1.49 #1 Sun Apr 15 18:12:33 MDT 2001 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0b
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         via82cxxx_audio ac97_codec binfmt_misc autofs
nls_iso8859-1 nls_cp437
cdrecord             1.9-6


"Hawthorne, Jim J SSI-ISEA" wrote:

> No problem with ext2 file system -- I have been using LM 7.2 with kernel
> 2.2.14 and it works straight out of the box. Newer kernel 2.4.x should also
> work .
> Have Toshiba w1101 scsi dvd ram and initio wide scsi card. I also use
> WINDOZE 2000 and use UDF for DVD RAM on WINDOZE 2000 (Instant Write from VOB
> at www.vob.de -- came with the drive).
>
> I use BRUBACK for backup to backup both Linux and W2K (Bruback will backup
> windoze filesystem from Linux -- no problem)
>
> format your media with mke2fs /dev/scd1 (or wherever your dvd ram is
> detected) -- just use defaults  takes about 1 min to format a 2.6 GB media.
>
> create a directory under /   say /dvdram
>
> then simply mount -t ext2 /dev/scd1 /dvdram      hey presto you should get
> read/write access to your drive
>
> your fstab entry should look something like this
>
> /dev/scd1 /dvdram ext2 noauto,rw,user,nosuid,sync
>
> I haven't played around with the UDF file system on LM 7.2 yet but if you
> keep separate media for Windoze and Linux then using ext2 for linux should
> not be a problem.
>
> BTW you can actually create a FAT32 file system on your device as well ( use
> DOSUTILS package) but perversely Windoze will not allow you to write to the
> device in this case ---- no driver available).  I understand that Windoze XP
> (or Whistler) will have native FAT32 support for DVD RAM drives.
>
> Hope this helps a bit
>
> cheers
> jim




