Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQJ3SQZ>; Mon, 30 Oct 2000 13:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129090AbQJ3SQQ>; Mon, 30 Oct 2000 13:16:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35402 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129026AbQJ3SQF>; Mon, 30 Oct 2000 13:16:05 -0500
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 30 Oct 2000 18:16:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux_developer@hotmail.com (Linux Kernel Developer),
        linux-kernel@vger.kernel.org
In-Reply-To: <4793.972914893@ocs3.ocs-net> from "Keith Owens" at Oct 31, 2000 01:08:13 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qJUE-00075t-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4 symbol generation code never sees the C++ names, 2.5 code might.
> To detect a mismatch between kernel headers and the module version
> file, I have to generate the checksum for the consumer of the symbol
> (C++) as well as the generator of the symbol (C) and compare them.

These are structure field names. They aren't part of a symbol and are only
part of your checksum computation which is done on the C headers so a constant.

If we were renaming variables or actual objects I'd agree. But structure names
are fine so long as we only use C names for the module checksum computation


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
