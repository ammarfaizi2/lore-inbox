Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbRGRCRB>; Tue, 17 Jul 2001 22:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267785AbRGRCQw>; Tue, 17 Jul 2001 22:16:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24728 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267743AbRGRCQi>;
	Tue, 17 Jul 2001 22:16:38 -0400
Date: Tue, 17 Jul 2001 22:16:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: dpicard@rcn.com
cc: axboe@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH for Corrupted IO on all block devices
In-Reply-To: <3B54E85E.6E917925@psind.com>
Message-ID: <Pine.GSO.4.21.0107172214440.1861-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Jul 2001, David J. Picard wrote:

>                 int i, buffer[RD_BUFF_SZ];
> 		fflush(fp);
>                 fseek(fp, o, SEEK_SET);
>                 fread(buffer, sizeof(int), sizeof(buffer), fp);
				^^^^^^^^^^^^^^^^^^^^^^^^^^^

You've just smashed the stack. Big way. Basically, all your local variables
are junk after that point.

