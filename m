Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319220AbSILVSW>; Thu, 12 Sep 2002 17:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319221AbSILVSV>; Thu, 12 Sep 2002 17:18:21 -0400
Received: from AMarseille-201-1-2-168.abo.wanadoo.fr ([193.253.217.168]:2160
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S319220AbSILVSV>; Thu, 12 Sep 2002 17:18:21 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Russell King" <rmk@arm.linux.org.uk>,
       "Mike Anderson" <andmike@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19 SCSI core bug?
Date: Thu, 12 Sep 2002 11:41:17 +0200
Message-Id: <20020912094117.10936@192.168.4.1>
In-Reply-To: <20020912174530.B3121@flint.arm.linux.org.uk>
References: <20020912174530.B3121@flint.arm.linux.org.uk>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>1. we need to come up with a way of reasonably handing SCSI medium
>   errors if we are going to use the READ10 command with the FUA
>   bit clear.
>
>2. we could just set the FUA bit and bypass the drives on-board
>   cache completely.
>
>Note that the only reason I've found this is because my HBA drives
>are _really_ pedantic about checking that all expected data does
>in fact get transferred by the drive.
>
>I wonder how many other drives out there are buggy like this. 8/

What about setting FUA on the next command after an error ?

Would this work or may the disk really keep stale data around ?

I don't have a recent SCSI spec at hand, but is there a command
we can send after an error to force a cache flush & invalidate
or will it only flush dirty datas to platter and not invalidate ?

Ben.



