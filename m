Return-Path: <linux-kernel-owner+w=401wt.eu-S932770AbWLSL0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbWLSL0L (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 06:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWLSL0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 06:26:11 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:27868 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932779AbWLSL0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 06:26:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=UecGQUcbg/5uOP7W2raiXXtkBz2lObRzpqK+jKuzzzMTAbNVUJXcPxFJCcWk1SpWpE50+r9V+/8tXbNJcJbvqqVLhJ/hFMRQOUt+VHL9CFkEaLGQF2rrUfj8U4VxOdbsxCs4dn2UwQeTzEEbzWTWYVxHgi3/gkEPr7bEioyuvnw=
Message-ID: <1b137cb70612190326g620f0c75r3d4d65bf379c9959@mail.gmail.com>
Date: Tue, 19 Dec 2006 12:26:07 +0100
From: "Roel Teuwen" <Roel.Teuwen@advalvas.be>
To: "Gregory Brauer" <greg@wildbrain.com>
Subject: Re: SATA300 TX4 + WD2500KS = status=0x50 { DriveReady SeekComplete }
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <453FD6B5.9080205@wildbrain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <453FD6B5.9080205@wildbrain.com>
X-Google-Sender-Auth: 75129ba0ee5eaf27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am seeing the exact same 'problem'. I have 4 WDC WD2500KS-00MJB0
drives connected to a promise SATA300 TX4. The messages have been
flooding syslog since the drives were installed. Running 2.6.18 or
2.6.19 vanilla kernels.

Best regards,

Roel Teuwen

On 10/25/06, Gregory Brauer <greg@wildbrain.com> wrote:
>
> I have a new Promise SATA300 TX4 4-port SATA controller
> to which I have attached two older WD2500JD hard drives
> and two brand new WD2500KS hard drives.  The older drives
> seem to work fine, but both of the brand new hard drives
> trigger the following errors every few seconds during
> i/o:
>
>
> Oct 25 13:57:18 gleep kernel: ata3: no sense translation for status: 0x50
> Oct 25 13:57:18 gleep kernel: ata3: translated ATA stat/err 0x50/00 to SCSI
> SK/ASC/ASCQ 0xb/00/00
> Oct 25 13:57:18 gleep kernel: ata3: status=0x50 { DriveReady SeekComplete }
> Oct 25 13:57:26 gleep kernel: ata1: no sense translation for status: 0x50
> Oct 25 13:57:26 gleep kernel: ata1: translated ATA stat/err 0x50/00 to SCSI
> SK/ASC/ASCQ 0xb/00/00
> Oct 25 13:57:26 gleep kernel: ata1: status=0x50 { DriveReady SeekComplete }
> Oct 25 13:57:27 gleep kernel: ata1: no sense translation for status: 0x50
> Oct 25 13:57:27 gleep kernel: ata1: translated ATA stat/err 0x50/00 to SCSI
> SK/ASC/ASCQ 0xb/00/00
> Oct 25 13:57:27 gleep kernel: ata1: status=0x50 { DriveReady SeekComplete }
> Oct 25 13:57:31 gleep kernel: ata1: no sense translation for status: 0x50
> Oct 25 13:57:31 gleep kernel: ata1: translated ATA stat/err 0x50/00 to SCSI
> SK/ASC/ASCQ 0xb/00/00
> Oct 25 13:57:31 gleep kernel: ata1: status=0x50 { DriveReady SeekComplete }
> Oct 25 13:57:47 gleep kernel: ata3: no sense translation for status: 0x50
> Oct 25 13:57:47 gleep kernel: ata3: translated ATA stat/err 0x50/00 to SCSI
> SK/ASC/ASCQ 0xb/00/00
> Oct 25 13:57:47 gleep kernel: ata3: status=0x50 { DriveReady SeekComplete }
>
>
> The machine stays running normally, and any processes doing data
> I/O do not pause noticeably, but these errors are very annoying.
> Is there anything I can do to help troubleshoot this?
>
> (Note that I am aware of the drive id mapping issue with my Promise
> controller, and I am *positive* that it is the two new drives that
> are the one's that the error messages refer to.)
>
> Thanks.
>
> Greg
>
>
> System Info
> -----------
>
> Fedora Core 5
> 2.6.18-1.2200.fc5smp
>
>
> Device Model:     WDC WD2500KS-00MJB0
> Firmware Version: 02.01C03
>
>
> # lspci
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
> (rev 03)
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
> (rev 03)
> 00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
> 00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
> 00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
> 00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
> 00:0b.0 Mass storage controller: Promise Technology, Inc. PDC20718 (SATA 300
> TX4) (rev 02)
> 00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
> 00:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
> 00:0f.0 Ethernet controller: Intel Corporation 82541PI Gigabit Ethernet
> Controller (rev 05)
> 00:11.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
> 00:11.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
> 00:11.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
> 00:11.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
> 00:11.4 FireWire (IEEE 1394): ALi Corporation M5253 P1394 OHCI 1.1 Controller
> 00:13.0 Mass storage controller: Triones Technologies, Inc.
> HPT366/368/370/370A/372/372N (rev 01)
> 00:13.1 Mass storage controller: Triones Technologies, Inc.
> HPT366/368/370/370A/372/372N (rev 01)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
