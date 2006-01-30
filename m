Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWA3PFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWA3PFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWA3PFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:05:05 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:55070 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932303AbWA3PFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:05:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ANblfgeF5SnXN4oWHxfX80iMCMk+DiQxiKO6j77SYdONSzHt4mywGawztgkaO/7kFCwJ8tU0jy+ml42xYZDKXaGeUWCsLB+CPdhkTOqqhmlULVR6Cw588hnO+IJ8NPvY6b8EXY4XAV4gKRY2d67lvXB2SjUdqnDSeI79BbSqo+g=
Message-ID: <43DE2B14.7090309@gmail.com>
Date: Tue, 31 Jan 2006 00:04:52 +0900
From: Tejun <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Lamanna <jlamanna@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: I/O errors while dding between 2 SATA drives
References: <aa4c40ff0601261021m1fe746feq172f0a34b6afd9ad@mail.gmail.com>
In-Reply-To: <aa4c40ff0601261021m1fe746feq172f0a34b6afd9ad@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Lamanna wrote:
> I received the following errors while executing a
> dd if=/dev/sdb of=/dev/sda bs=1M
> between 2 500GB SATA Seagate Barracuda drives on 2.6.12 (Gentoo 2005.1
> "Live" CD)
> 
> ata1: command 0x35 timeout stat 0xd1 host_stat 0x21
> ata1: status=0xd1 { Busy }
> end request: I/O Error dev sda, sector 51188392
> Buffer I/O Error on device sda, logical block 6398549
> lost page write due to I/O Error on sda
> ATA: abnormal status 0xD1 on port 0x9F7
> ATA: abnormal status 0xD1 on port 0x9F7
> ATA: abnormal status 0xD1 on port 0x9F7
> 
> The message repeats every so often with the sector count increasing by
> 8 and logical block count increasing by 1.
> 
> Is it bad hardware? (sda is brand new)
> And is the copy hosed?
> 

[CC'ing linux-ide]

Hi, James.

Please post full dmesg and yeah the copy is probably hosed.  dd's exit 
code will tell you.  Do 'echo $$'.

-- 
tejun
