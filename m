Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423002AbWJYFZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423002AbWJYFZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 01:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423001AbWJYFZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 01:25:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:12608 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423002AbWJYFZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 01:25:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=urMYwuacJn801eQmMVVspLHgC3JJvySqIqYZ+JMPc2EetcNRiEDIk0PMmyNexz6wtMyRcTq9GFmCU2zDMYTbws9E13+7ccq9LYnsUj7bAq8ekCftz3vcSUehg10PUcrBwAh+w/zC89ius0LZclRKzCODuot05OBwhGKXEPaaxMI=
Message-ID: <acd894d40610242225p463bc42fjcbddd2de0c103974@mail.gmail.com>
Date: Wed, 25 Oct 2006 00:25:30 -0500
From: "Ian Williamson" <notian@gmail.com>
To: Michael <michael.sallaway@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: md raid 5 with xfs copying data through Samba
In-Reply-To: <453eed13.28711386.4666.ffffea7c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <acd894d40610242128j3a5d7f2do99684fca215bb4d2@mail.gmail.com>
	 <453eed13.28711386.4666.ffffea7c@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

It does the same thing that happens when I cd to the mount point. The
Putty terminal stops responding (not Windows style, just no output,
etc.)

I am running the PROMISE SATA300 TX4 PCI SATA II 4:
http://www.newegg.com/product/product.asp?item=N82E16816102065

Before I was running the Rosewill Rc-209:
http://www.newegg.com/Product/Product.asp?Item=N82E16816132006

I had the same problems with both cards. For the hard drives I'm using
four Seagate Barracuda 7200.10 ST3250820AS 250GB drives. I have an AMD
Athlon 2800+ with 1 GB of ram on a nforce 2 chipset.

- Ian Williamson

On 10/24/06, Michael <michael.sallaway@gmail.com> wrote:
> Hi Ian,
>
> I'm having a similar problem... try doing a `dd if=/dev/zero of=/dev/md0
> bs=512K` (warning -- will trash your /dev/md0), and see if it can do the
> whole thing without complaining.
>
> Also, what hardware do you have? Chipset, processor, etc., etc...
>
> Cheers,
> Michael
>
>
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Ian
> > Williamson
> > Sent: Wednesday, 25 October 2006 2:28 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: md raid 5 with xfs copying data through Samba
> >
> > Hello,
> >
> > I have a Promise PCI SATA card that has 4 drives attached to it. I am
> > running software raid 5 with an xfs file system on md0.
> > /dev/md0:
> >         Version : 00.90.03
> >   Creation Time : Tue Oct 24 18:58:32 2006
> >      Raid Level : raid5
> >      Array Size : 732587520 (698.65 GiB 750.17 GB)
> >     Device Size : 244195840 (232.88 GiB 250.06 GB)
> >    Raid Devices : 4
> >   Total Devices : 4
> > Preferred Minor : 0
> >     Persistence : Superblock is persistent
> >
> >     Update Time : Tue Oct 24 22:44:56 2006
> >           State : active
> >  Active Devices : 4
> > Working Devices : 4
> >  Failed Devices : 0
> >   Spare Devices : 0
> >
> >          Layout : left-symmetric
> >      Chunk Size : 128K
> >
> >            UUID : f801e705:94b9c801:8fd7c3fa:2031ddfd
> >          Events : 0.54765
> >
> >     Number   Major   Minor   RaidDevice State
> >        0       8        1        0      active sync   /dev/sda1
> >        1       8       17        1      active sync   /dev/sdb1
> >        2       8       33        2      active sync   /dev/sdc1
> >        3       8       49        3      active sync   /dev/sdd1
> >
> >
> > When I try to copy files through Samba I get the following in
> > /var/log/messages:
> > -----------------------
> > Oct 24 22:44:57 iann kernel: [42950421.330000] Modules linked in: xfs
> > exportfs ipv6 dm_mod lp snd_mpu401 snd_mpu401_uart parport_pc
> > snd_rawmidi snd_seq_device r1000 r8169 parport analog gameport pcspkr
> > snd_intel8x0 snd_ac97_codec snd_ac97_bus floppy snd_pcm_oss
> > snd_mixer_oss snd_pcm snd_timer snd soundcore shpchp snd_page_alloc
> > pci_hotplug psmouse serio_raw i2c_nforce2 i2c_core forcedeth
> > nvidia_agp agpgart sg evdev reiserfs raid5 md_mod xor ide_generic
> > ehci_hcd ohci_hcd usbcore ide_cd cdrom ide_disk sata_nv generic
> > amd74xx sd_mod sata_promise libata scsi_mod thermal processor fan
> > capability commoncap vga16fb vgastate fbcon tileblit font bitblit
> > softcursor
> > Oct 24 22:44:57 iann kernel: [42950421.330000] CPU:    0
> > Oct 24 22:44:57 iann kernel: [42950421.330000] EIP:
> > 0060:[__bread+52/80]    Not tainted VLI
> > Oct 24 22:44:57 iann kernel: [42950421.330000] EFLAGS: 00210292   (
> > 2.6.15-26-server)
> > Oct 24 22:44:57 iann kernel: [42950421.330000] EIP is at
> > __bread+0x34/0x50
> > Oct 24 22:44:57 iann kernel: [42950421.330000] eax: 00000001   ebx:
> > f2dff540   ecx: c7ce79f8   edx: c01755a0
> > Oct 24 22:44:57 iann kernel: [ 42950421.330000] esi: f7ee965c   edi:
> > f2dff540   ebp: 00000000   esp: c1b07e94
> > Oct 24 22:44:57 iann kernel: [42950421.330000] ds: 007b   es:
> > 007b   ss: 0068
> > Oct 24 22:44:57 iann kernel: [42950421.330000] Process md0_raid5 (pid:
> > 2279, threadinfo=c1b06000 task=c1a85030)
> > Oct 24 22:44:57 iann kernel: [42950421.330000] Stack: c01775f0
> > c7ce79f8 00000001 f2df9620 f8918a63 f2dff540 00001000 00000000
> > Oct 24 22:44:57 iann kernel: [42950421.330000]        00000008
> > 00000001 00000000 c1a85030 c1a85030 000001b0 c1807060 0da6c120
> > Oct 24 22:44:57 iann kernel: [42950421.330000]        00000000
> > f7ee968c c030762c c1b07f58 00000000 c1807060 c1807a80 c1a69400
> > Oct 24 22:44:57 iann kernel: [42950421.330000] Call Trace:
> > Oct 24 22:44:57 iann kernel: [ 42950421.330000]
> > [end_bio_bh_io_sync+48/112] end_bio_bh_io_sync+0x30/0x70
> > Oct 24 22:44:57 iann kernel: [42950421.330000]
> > [pg0+944495203/1069167616] handle_stripe+0xbb3/0x1450 [raid5]
> > Oct 24 22:44:57 iann kernel: [ 42950421.330000]  [schedule+1372/3440]
> > schedule+0x55c/0xd70
> > Oct 24 22:44:57 iann kernel: [42950421.330000]
> > [__generic_unplug_device+26/48] __generic_unplug_device+0x1a/0x30
> > Oct 24 22:44:57 iann kernel: [42950421.330000 ]
> > [pg0+944484391/1069167616] release_stripe+0x27/0x190 [raid5]
> > Oct 24 22:44:57 iann kernel: [42950421.330000]
> > [pg0+944500176/1069167616] raid5d+0x170/0x300 [raid5]
> > Oct 24 22:44:57 iann kernel: [42950421.330000]
> > [pg0+944733917/1069167616] md_thread+0x4d/0x150 [md_mod]
> > Oct 24 22:44:57 iann kernel: [42950421.330000]
> > [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
> > Oct 24 22:44:57 iann kernel: [42950421.330000]
> > [pg0+944733840/1069167616] md_thread+0x0/0x150 [md_mod]
> > Oct 24 22:44:57 iann kernel: [42950421.330000]  [kthread+200/208]
> > kthread+0xc8/0xd0
> > Oct 24 22:44:57 iann kernel: [42950421.330000]
> > [kthread+0/208] kthread+0x0/0xd0
> > Oct 24 22:44:57 iann kernel: [42950421.330000]
> > [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
> > Oct 24 22:44:57 iann kernel: [42950421.330000] Code: 24 1c 89 44 24 0c
> > 8b 44 24 18 89 54 24 08 89 44 24 04 8b 44 24 14 89 04 24 e8 f9 fe ff
> > ff 85 c0 89 c2 74 06 8b 00 a8 01 74 0d 89 <d0> 83 c4 10 c3 8d b4 26 00
> > 00 00 00 89 54 24 14 83 c4 10 e9 34
> >
> > Then the transfer fails. When I ssh into the machine, I cd to the
> > mount point of md0, and the terminal inside of Putty stops responding,
> > Ctrl C doesn't work. I am forced to close the connection
> > I have tried two different PCI SATA cards and they have both had this
> > happen. Any ideas on what could be causing this?
> >
> > PLEASE CC ME WITH ANY RESPONSES, I'M NOT SUBSCRIBED TO THE
> > KERNEL LIST.
> > Thanks,
> > Ian Williamson
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>


-- 
Ian Williamson
