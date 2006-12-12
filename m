Return-Path: <linux-kernel-owner+w=401wt.eu-S932279AbWLLRaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWLLRaN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWLLRaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:30:13 -0500
Received: from smtpauth02.prod.mesa1.secureserver.net ([64.202.165.182]:53948
	"HELO smtpauth02.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932275AbWLLRaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:30:11 -0500
Message-ID: <457EE721.2090509@seclark.us>
Date: Tue, 12 Dec 2006 12:30:09 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata and sata?
References: <457ED87A.5@comcast.net>
In-Reply-To: <457ED87A.5@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>A while back my distro moved to libata for sata_via.  I was since
>confused; my disk seemed a lot slower, and it looked like DMA was off.
>I'm not sure how SATA works; is it even possible to enable/disable
>32-bit IO and DMA?  Or are those just on?
>
>sata_via               11524  4
>libata                112660  3 ata_generic,pata_via,sata_via
>
>~$ sudo hdparm -d1 -c1 -u1 /dev/sda
>
>/dev/sda:
> setting 32-bit IO_support flag to 1
> HDIO_SET_32BIT failed: Invalid argument
> setting unmaskirq to 1 (on)
> HDIO_SET_UNMASKINTR failed: Inappropriate ioctl for device
> setting using_dma to 1 (on)
> HDIO_SET_DMA failed: Inappropriate ioctl for device
> IO_support   =  0 (default 16-bit)
>
>I no longer have two kernels to test through; I can't tell if the speed
>is back or not.  Nothing in dmesg tells me if SATA is using DMA or
>32-bit IO support though, so I don't know... lack of knowledge over here
>is killing me for troubleshooting this on my own.
>
>  
>
<snip>

Hi John,

This happened to me with my ICH7 intel chipset which supports sata and ata - my drive was an ide and the performance was like 1.2mb/sec. Someone said boot with combined_mode=libata and it fixed the problem.
Now I get 44mb/sec.

HTH,
Steve
-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



