Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUCaS6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUCaS6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:58:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36545 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262311AbUCaS62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:58:28 -0500
Message-ID: <406B14C1.8000708@pobox.com>
Date: Wed, 31 Mar 2004 13:58:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Andre Hedrick <andre@linux-ide.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Bogus LBA48 drives
References: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be> <Pine.LNX.4.10.10403300821520.11654-100000@master.linux-ide.org> <20040331183410.GA3796@pclin040.win.tue.nl>
In-Reply-To: <20040331183410.GA3796@pclin040.win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> Hmm. I read in my copy of ATA7:
> 
>  6.16.55 Words (103:100): Maximum user LBA for 48-bit Address feature set
>  Words (103:100) contain a value that is one greater than the maximum LBA
>  in user accessable space when the 48-bit Addressing feature set is supported.
>  The maximum value that shall be placed in this field is 0000FFFFFFFFFFFFh.
>  Support of these words is mandatory if the 48-bit Address feature set is supported.
> 
> Do you read differently?

The errata is, one needs to check that field for zero, and use the other 
one if so...

	Jeff



