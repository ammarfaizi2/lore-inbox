Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312940AbSCZEAS>; Mon, 25 Mar 2002 23:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312939AbSCZEAI>; Mon, 25 Mar 2002 23:00:08 -0500
Received: from dsl081-147-127.chi1.dsl.speakeasy.net ([64.81.147.127]:32370
	"HELO coral.cfftechnologies.com") by vger.kernel.org with SMTP
	id <S312938AbSCZD76>; Mon, 25 Mar 2002 22:59:58 -0500
Subject: 1G Microdrive problems
From: Avi Schwartz <avi@CFFtechnologies.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2- 
Date: 25 Mar 2002 21:59:56 -0600
Message-Id: <1017115196.6309.62.camel@seahorse>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am looking for a pointer on where I can find help with a problem I am
having with the IBM 1G Microdrive and Linux.  The problem I am having is
not distribution specific.

The problem is that when I connect my digital camera (Olympus E-20) to
my computer via USB (or the microdrive directly to my laptop via the
PCMCIA adapter), trying to list the files on the disk displays a corrupt
directory structure:

> ls /mnt/camera
dcim

> ls /mnt/camera/dcim
100olymp

> ls -l /mnt/dcim/100olymp/
dr-xr-xr-x    0 root     root        32768 Aug 10  1996 j4???h?".j?k
-r-xr-xr-x    1 root     root     3547043402 Jun 20  2020 j{?e?8^?.c{?
drwxr-xr-x  50768 root     root      3145728 Jan  1  2022 j?+?????.???
drwxr-xr-x    0 root     root        32768 Dec 15  1911 kg?}?hv".???
drwxr-xr-x    0 root     root        32768 Jan 14  1987 lt??????.???
-r-xr-xr-x    1 root     root     290476329 Jan  4  1918 o?a?=??e.?8?
-rwxr-xr-x    1 root     root      3650885 Dec 21 09:14 pc210028.jpg
-rwxr-xr-x    1 root     root      3513694 Dec 21 09:16 pc210029.jpg
-rwxr-xr-x    1 root     root      3653888 Dec 21 09:17 pc210030.jpg
-rwxr-xr-x    1 root     root      3850982 Dec 23 19:50 pc230031.jpg
...

I tried it with different units, all had the same problem.

I formatted it more then once to make sure that the directory
stucture is not corrupt and even then it displayed what seems to be a
broken directory structure (i.e. when empty).

One thing to note is that the disk is formatted as fat, i.e. it is not
ext2/3. 

It is not machine specific since I tried it with my desktop (via USB) as
well as my laptop (via PCMCIA adapter).

The laptop is IDE based.  The desktop is SCSI.

The 'other' OS has no problem with these drives.

$ uname -a (on laptop)
Linux seahorse 2.4.18 #3 Wed Feb 27 19:09:37 CST 2002 i686 GenuineIntel

Desktop is running kernel 2.4.7-SMP on a dual processor Athlon machine.

I can only think it might be a problem with the fat driver, any idea
what may be the problem?

Thanks,
Avi

-- 
Avi Schwartz
avi@CFFtechnologies.com

