Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285303AbRLNBbN>; Thu, 13 Dec 2001 20:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285304AbRLNBbD>; Thu, 13 Dec 2001 20:31:03 -0500
Received: from vortex.physik.uni-konstanz.de ([134.34.143.44]:9490 "EHLO
	vortex.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S285303AbRLNBay>; Thu, 13 Dec 2001 20:30:54 -0500
Message-Id: <200112140130.fBE1Ujs19271@vortex.physik.uni-konstanz.de>
Content-Type: text/plain; charset=US-ASCII
From: space-00002@vortex.physik.uni-konstanz.de
Organization: Universitaet Konstanz/Germany
To: linux-kernel@vger.kernel.org
Subject: Re: buffer/memory strangeness in 2.4.16; fixed in 2.4.17-rc1
Date: Fri, 14 Dec 2001 02:30:46 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200111291201.fATC1pd04206@lists.us.dell.com> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just to let you know the problem described below seems to have been fixed in 
2.4.17-rc1. It behaves as it should. Great work!

Cheers,
	Jan

On Thursday 29 November 2001 21:39, you wrote:
> Hi,
>
> I am experiencing a bit of strange system behaviour in a vanilla 2.4.16
> kernel (2.95.3, very stable machine etc.)
>
> I noticed, that after running for a while (day) I had significantly less
> memory available for my simulation program than right after booting.
> Looking at the problem using 'xosview' (or 'free'), I noticed that there
> was a large number of MBs filled with 'buffers' that did not get wiped when
> other programs need the memory. The system seems to rather kill an
> 'offender' than clean out buffers.
>
> Right after booting, I can allocate about 650MBs memory using the little
> program attached below. After a day (or after running updatedb), under the
> same conditions, even in single user mode with only a shell running (!)
> this is not possible anymore and the program (below), trying to allocate
> only 300-400MBs, gets killed by the system after making it unresponsive for
> many seconds.
>
> Apparently this problem occurs after running 'updatedb', which fills 'free
> memory' and generates lots of filled cache and buffers on my system.
>
> This sort of behaviour must have been introduced after 2.4.13, which does
> not show these problems.
