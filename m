Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFNN7>; Wed, 6 Dec 2000 08:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbQLFNNt>; Wed, 6 Dec 2000 08:13:49 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:58065 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S129183AbQLFNNh>;
	Wed, 6 Dec 2000 08:13:37 -0500
Message-ID: <3A2E345C.EE6F5640@student.ethz.ch>
Date: Wed, 06 Dec 2000 13:43:08 +0100
From: Giacomo Catenazzi <cate@student.ethz.ch>
X-Mailer: Mozilla 4.73 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@redhat.com>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <fa.mnh2nkv.1kkusq6@ifi.uio.no> <fa.enh20bv.1pkea3o@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2000 12:43:08.0952 (UTC) FILETIME=[1637D980:01C05F82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> 
> Good question.  The whole thing makes me nervous... in fact, perhaps we
> should really consider using the BIOS INT 15h interrupt to enter
> protected mode?
> 

Maybe it is better to try with INT15 AX=2400 (Enable A20 gate). 

INT 15-2400 enable A20
INT 15-2401 disable A20
INT 15-2402 query status A20
INT 15-2403 query A20 support (kdb or port 92)

IBM classifies these functions as optional, but it is enabled on a lot
of
new BIOS, no know conflicts, thus we can call this function to enable
A20,
check the result and only after failure we can try the old methods.


	giacomo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
