Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281519AbRKMLpx>; Tue, 13 Nov 2001 06:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281609AbRKMLpe>; Tue, 13 Nov 2001 06:45:34 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2831 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281608AbRKMLpX>; Tue, 13 Nov 2001 06:45:23 -0500
Date: Tue, 13 Nov 2001 12:45:19 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: joeja@mindspring.com
Subject: Re: 2.4.9 to 2.4.14 bug & workaround
Message-ID: <20011113124519.G3949@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, joeja@mindspring.com
In-Reply-To: <Springmail.105.1005600219.0.18983900@www.springmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Springmail.105.1005600219.0.18983900@www.springmail.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, joeja@mindspring.com wrote:

(reformatted quote to heed line length provisions)
> I have an internal iomega 'type' (not iomega) IDE zip drive.  It
> mounts as /dev/hdd instead of /dev/hdd4.  Mounting as /dev/hdd seems
> okay.
> 
> Mounting as /dev/hdd4 will hang my kernel( 2.4.9-2.4.14).  I have read
> that on some MB you can change the bios to none for the ide device and
> this works on certain mb.  I tried this and it did not change
> anything.

Well, all this depends on how the media has been formatted. From what I
heard (I have no exchangable drives since I sold my SyQuest crap), some
ZIP (presumably) media are partitioned and have their fourth partition
formatted, giving your data as /dev/hdd4 or /dev/sdb4 or something other
with 4 to the end. Then, the entire media might be formatted "raw" with
Linux, so you'd have to mount /dev/hdd instead.

The BIOS is only involved for booting and come APM or ACPI (power
saving) stuff, maybe also for VESA frame buffer stuff, but other than
that, its settings are partially read and the BIOS is no longer taken
into account.

Of course, a system hang is Not Nice[tm] and should be fixed by the
respective maintainers IF IT IS an actual bug. Please check the cabling
or use hdparm to use more conservative transfer modes before assuming
it's a bug with Linux -- a "cp" hang certainly warrants investigation.

OTOH, mount should not hang if you mount the wrong part of the disk, but
complain instead, however, I'm not sure if a bogus partition entry can
cause these hangs.
