Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313536AbSDHCR0>; Sun, 7 Apr 2002 22:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313540AbSDHCRZ>; Sun, 7 Apr 2002 22:17:25 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:1811 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313536AbSDHCRY>; Sun, 7 Apr 2002 22:17:24 -0400
Message-ID: <3CB0EF0B.14D48619@zip.com.au>
Date: Sun, 07 Apr 2002 18:14:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: nahshon@actcom.co.il, Pavel Machek <pavel@suse.cz>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> But I *want* to write while the drive is spun down. And leave it spun
> down until the system is RAM starved (or some threshold is reached).
> 

Yes.  The desirable behaviour for laptops is to defer writes
for a very long time, or until the user says "sync".

Mechanisms need to be put in place so that if there are pending
writes and the disk happens to be spun up for a read, we take
advantage of that spinup to push out the pending writes at
the same time.

This behaviour should be all be enabled by a special "laptop mode"
switch.

There's nothing particularly hard in all this...  I'll do a 2.5
version at some stage.

-
