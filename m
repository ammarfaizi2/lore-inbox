Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUCaSe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbUCaSe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:34:26 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:12810 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262046AbUCaSeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:34:20 -0500
Date: Wed, 31 Mar 2004 20:34:10 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Bogus LBA48 drives
Message-ID: <20040331183410.GA3796@pclin040.win.tue.nl>
References: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be> <Pine.LNX.4.10.10403300821520.11654-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10403300821520.11654-100000@master.linux-ide.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:

>> Apparently some IDE drives (e.g. a pile of 80 GB ST380020ACE drives I have
>> access to) advertise to support LBA48, but don't.
>> One problem with those drives is that the lba_capacity_2 field in their drive
>> identification is set to 0.


Andre Hedrick replies:

> Actually this issue an errata correction in ATA-6 and changed in ATA-7.
> 
> 48-bit command set support is different than capacity.


Hmm. I read in my copy of ATA7:

 6.16.55 Words (103:100): Maximum user LBA for 48-bit Address feature set
 Words (103:100) contain a value that is one greater than the maximum LBA
 in user accessable space when the 48-bit Addressing feature set is supported.
 The maximum value that shall be placed in this field is 0000FFFFFFFFFFFFh.
 Support of these words is mandatory if the 48-bit Address feature set is supported.

Do you read differently?
