Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUIPHUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUIPHUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 03:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUIPHUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 03:20:31 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:9223 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S267810AbUIPHSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 03:18:49 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM can't be ejected
Date: Thu, 16 Sep 2004 09:18:40 +0200
User-Agent: KMail/1.6.2
References: <200409160025.35961.cijoml@volny.cz> <20040916070906.GK2300@suse.de>
In-Reply-To: <20040916070906.GK2300@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Q5TSBbZqCRjVflf"
Message-Id: <200409160918.40767.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Q5TSBbZqCRjVflf
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

notas:/home/cijoml# mount /cdrom/
notas:/home/cijoml# umount /cdrom/
notas:/home/cijoml# strace -o eject /dev/hdc
eject: unable to eject, last error: Nep=F8=EDpustn=FD argument

As you can see, I dont't enter to directory...

And output is included

M.

Dne =E8t 16. z=E1=F8=ED 2004 09:09 jste napsal(a):
> On Thu, Sep 16 2004, Bc. Michal Semler wrote:
> > Hi,
> >
> > it's almost half a year, when I filled this bug report:
> > http://bugme.osdl.org/show_bug.cgi?id=3D2951
> >
> > and it still don't work :)
> >
> > Can anybody help me?
>
> strace -o some_file eject /dev/hdc
>
> and send some_file in here.

--Boundary-00=_Q5TSBbZqCRjVflf
Content-Type: text/plain;
  charset="iso-8859-2";
  name="eject"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="eject"

execve("/usr/bin/eject", ["eject", "/cdrom/"], [/* 30 vars */]) = 0
uname({sys="Linux", node="notas", ...}) = 0
brk(0)                                  = 0x804e000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=44185, ...}) = 0
old_mmap(NULL, 44185, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340X\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1279044, ...}) = 0
old_mmap(NULL, 1289356, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40023000
old_mmap(0x40153000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12f000) = 0x40153000
old_mmap(0x4015c000, 7308, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4015c000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4015e000
set_thread_area({entry_number:-1 -> 6, base_addr:0x4015e2a0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0x40018000, 44185)               = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=293184, ...}) = 0
mmap2(NULL, 293184, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4015f000
close(3)                                = 0
brk(0)                                  = 0x804e000
brk(0x806f000)                          = 0x806f000
brk(0)                                  = 0x806f000
access("/cdrom", F_OK)                  = 0
readlink("/cdrom", 0xbfffea70, 4095)    = -1 EINVAL (Invalid argument)
stat64("/cdrom", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/etc/mtab", O_RDONLY)             = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=266, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401a7000
read(3, "/dev/hda2 / ext3 rw,errors=remou"..., 4096) = 266
stat64("/dev/hda2", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 2), ...}) = 0
stat64("proc", 0xbfffed5c)              = -1 ENOENT (No such file or directory)
stat64("sysfs", 0xbfffed5c)             = -1 ENOENT (No such file or directory)
stat64("devpts", 0xbfffed5c)            = -1 ENOENT (No such file or directory)
stat64("tmpfs", 0xbfffed5c)             = -1 ENOENT (No such file or directory)
stat64("usbfs", 0xbfffed5c)             = -1 ENOENT (No such file or directory)
stat64("/dev/hda1", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 1), ...}) = 0
stat64("none", 0xbfffed5c)              = -1 ENOENT (No such file or directory)
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x401a7000, 4096)                = 0
open("/etc/fstab", O_RDONLY)            = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=576, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401a7000
read(3, "# /etc/fstab: static file system"..., 4096) = 576
close(3)                                = 0
munmap(0x401a7000, 4096)                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/gconv/gconv-modules", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=45278, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401a7000
read(3, "# GNU libc iconv configuration.\n"..., 4096) = 4096
read(3, ".B1.002//\nalias\tJS//\t\t\tJUS_I.B1."..., 4096) = 4096
read(3, "859-3\t1\nmodule\tINTERNAL\t\tISO-885"..., 4096) = 4096
read(3, "9-14//\nalias\tLATIN8//\t\tISO-8859-"..., 4096) = 4096
read(3, "CSEBCDICES//\t\tEBCDIC-ES//\nalias\t"..., 4096) = 4096
read(3, "IBM284//\nalias\tEBCDIC-CP-ES//\t\tI"..., 4096) = 4096
read(3, "ias\t864//\t\t\tIBM864//\nalias\tCSIBM"..., 4096) = 4096
read(3, "\tIBM937\t\t1\nmodule\tINTERNAL\t\tIBM9"..., 4096) = 4096
read(3, "UC-JP//\nmodule\tEUC-JP//\t\tINTERNA"..., 4096) = 4096
read(3, "143IECP271//\tIEC_P27-1//\nalias\tI"..., 4096) = 4096
read(3, "\nmodule\tINTERNAL\t\tISO_10367-BOX/"..., 4096) = 4096
read(3, "\t\tto\t\t\tmodule\t\tcost\nmodule\tShift"..., 4096) = 222
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x401a7000, 4096)                = 0
open("/usr/lib/gconv/ISO8859-2.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\6\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=7744, ...}) = 0
old_mmap(NULL, 10684, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401a7000
old_mmap(0x401a9000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1000) = 0x401a9000
close(3)                                = 0
open("/etc/mtab", O_RDONLY)             = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=266, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401aa000
read(3, "/dev/hda2 / ext3 rw,errors=remou"..., 4096) = 266
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x401aa000, 4096)                = 0
open("/dev/hdc", O_RDONLY|O_NONBLOCK)   = 3
ioctl(3, CDROMEJECT, 0xbffffac8)        = -1 EIO (Input/output error)
ioctl(3, FIBMAP, 0xbffff970)            = 0
ioctl(3, FIBMAP, 0xbffff970)            = 0
ioctl(3, FIBMAP, 0xbffff970)            = 0
ioctl(3, BLKRRPART, 0xbffff970)         = -1 EINVAL (Invalid argument)
ioctl(3, FDEJECT, 0xbffffac8)           = -1 EINVAL (Invalid argument)
ioctl(3, MGSL_IOCGPARAMS or MTIOCTOP or SNDCTL_MIDI_MPUMODE, 0xbffffa80) = -1 EINVAL (Invalid argument)
open("/usr/share/locale/locale.alias", O_RDONLY) = 5
fstat64(5, {st_mode=S_IFREG|0644, st_size=2539, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401aa000
read(5, "# Locale name alias data base.\n#"..., 4096) = 2539
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0x401aa000, 4096)                = 0
open("/usr/share/locale/cs_CZ/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/cs/LC_MESSAGES/libc.mo", O_RDONLY) = 5
fstat64(5, {st_mode=S_IFREG|0644, st_size=86276, ...}) = 0
mmap2(NULL, 86276, PROT_READ, MAP_PRIVATE, 5, 0) = 0x401aa000
close(5)                                = 0
open("/usr/share/locale/cs_CZ/LC_MESSAGES/eject.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/cs/LC_MESSAGES/eject.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "eject: unable to eject, last err"..., 57) = 57
exit_group(1)                           = ?

--Boundary-00=_Q5TSBbZqCRjVflf--
