Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132529AbRDNTZs>; Sat, 14 Apr 2001 15:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132533AbRDNTZi>; Sat, 14 Apr 2001 15:25:38 -0400
Received: from a-pr9-44.tin.it ([212.216.147.171]:15490 "EHLO
	eris.discordia.loc") by vger.kernel.org with ESMTP
	id <S132529AbRDNTZ3>; Sat, 14 Apr 2001 15:25:29 -0400
Date: Sat, 14 Apr 2001 21:25:25 +0200 (CEST)
From: Lorenzo Marcantonio <lomarcan@tin.it>
To: <linux-kernel@vger.kernel.org>
Subject: Re: SCSI tape corruption problem
In-Reply-To: <200104140822.KAA30156@vulcan.alphanet.ch>
Message-ID: <Pine.LNX.4.31.0104142124390.1307-100000@eris.discordia.loc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Marc SCHAEFER wrote:

> Now try this:
>
>    cd ~archive
>    mt -f /dev/tapes/tape0 rewind
>    tar cvf - . | gzip -9 | dd of=/dev/tapes/tape0 bs=32k
>
> and then:
>
>    mt -f /dev/tapes/tape0 rewind
>    dd if=/dev/tapes/tape0 bs=32k | gzip -d | tar --compare -v -f -
>
> The above is the proper way to talk to a tape drive through gzip.

I see the blocking part... but in my second experiment I've used ONLY
dd to put a large file on tape...

... still, I've investigated on this because amverify gave me a ton of
crc errors... (I REALLY hope that amanda uses proper blocking :)

				-- Lorenzo Marcantonio


