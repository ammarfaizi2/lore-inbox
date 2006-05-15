Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWEOXgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWEOXgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWEOXgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:36:52 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:50836 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750789AbWEOXgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:36:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rWvGL4hNPsscUIAPRTbVboTZhoYd2HxbKbwt0PstSoeteAdk8elnTUNgL0o/IwhcqOi7GYj8wJTdJpLTN1a3CnRQF1+xIAey1D5ftGREno0Ghh4qvgrc4rbaWvbQy1wlUKxFYQ/kX/DQ+TsKJ5siZZAsvVrLE3YAPtPXu8hGC4M=
Message-ID: <4469108E.1030502@gmail.com>
Date: Tue, 16 May 2006 08:36:46 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Avuton Olrich <avuton@gmail.com>
CC: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
In-Reply-To: <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich wrote:
> On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
>> * sata_sil and ata_piix also need healthy re-testing of all basic
>> functionality.
> 
> I'm testing it right now, but with 2.6.17-rc4-git2 I was getting:
> 
> May 15 15:42:57 shapeshifter ata2: command 0x25 timeout, stat 0x58 
> host_stat 0x1
> May 15 15:42:57 shapeshifter ata2: translated ATA stat/err 0x58/00 to
> SCSI SK/ASC/ASCQ 0xb/47/00
> May 15 15:42:57 shapeshifter ata2: status=0x58 { DriveReady
> SeekComplete DataRequest }
> May 15 15:42:57 shapeshifter sd 1:0:0:0: SCSI error: return code = 
> 0x8000002
> May 15 15:42:57 shapeshifter sda: Current: sense key=0xb
> May 15 15:42:57 shapeshifter ASC=0x47 ASCQ=0x0
> May 15 15:42:57 shapeshifter end_request: I/O error, dev sda, sector 
> 974708575

2.6.17-rc4-git2 doesn't contain the changes.  You're still using old EH. 
  To test the updates, pull #upstream from libata-dev git tree which can 
be found on http://kernel.org/git.  Otherwise, you can try 
libata-tj-stable patch over 2.6.16.16 located at

http://home-tj.org/wiki/index.php/Libata-tj-stable.

-- 
tejun
