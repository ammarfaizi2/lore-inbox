Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRBMTzL>; Tue, 13 Feb 2001 14:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129583AbRBMTzB>; Tue, 13 Feb 2001 14:55:01 -0500
Received: from [192.234.226.14] ([192.234.226.14]:49505 "EHLO
	smtp.navtechinc.com") by vger.kernel.org with ESMTP
	id <S129159AbRBMTyv>; Tue, 13 Feb 2001 14:54:51 -0500
Message-ID: <3A8990D0.3070209@navtechinc.com>
Date: Tue, 13 Feb 2001 14:53:52 -0500
From: "N. Jason Kleinbub" <jkleinbub@navtechinc.com>
Organization: Navtech, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; 0.7) Gecko/20010109
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: Selects on dirs/files.
In-Reply-To: <3A894282.5070909@navtechinc.com> <3A8949B5.6BEDA269@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Manfred Spraul wrote:

 > "N. Jason Kleinbub" wrote:
 >> People,
 >>
 >> Not sure where to go from here but ....
 >>
 >>         ( Yes I have read the FAQ )=
 >>
 >> For practical reasons, I have created some modification to the
 >> Linux kernel.  These changes were to make our implementation of
 >> software more convenient (elegant).  Essentially, I have modified the
 >> select() calls to allow the non-trivial use of directories as an 'fd'.
 >>
 > Have you checked the F_NOTIFY fcntl()?
 >
 > If yes, what's the difference between your patch and F_NOTIFY?

The biggest impediment that I saw with F_NOTIFY was the inability
to distinguish _which_ directory generated the signal.  This was
especially problematic for multithreaded apps.  Also I would have
a chance of missing the signal if they pile ontop of each other.
Everytime I was interupted from my sleep() by a signal I would
have to scan _each_ directory to find the next file.

I admit, however, that the current F_NOTIFY has more functionality
then the current select().

Plus, for our programmers, it is a stylistic choice.  They prefer,
and better understand, using select()/poll() versus signal io.


