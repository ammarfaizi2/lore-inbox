Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTEBAGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTEBAF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:05:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55057 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262831AbTEBAFz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:05:55 -0400
Date: Fri, 2 May 2003 02:17:58 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Justin T. Gibbs" <gibbs@btc.adaptec.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Aic7xxx and Aic79xx Driver Updates
Message-ID: <20030502001758.GA20977@alpha.home.local>
References: <1866260000.1051828092@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1866260000.1051828092@aslan.btc.adaptec.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 04:28:12PM -0600, Justin T. Gibbs wrote:
> Folks,
> 
> I've just uploaded version 1.3.8 of the aic79xx driver and version 
> 6.2.33 of the aic7xxx driver.  Both are available for 2.4.X and
> 2.5.X kernels in either bk send format or as a tarball from here:
> 
> http://people.FreeBSD.org/~gibbs/linux/SRC/

Hi Justin,

I've just tested it and I still have the deadlock on SMP. I also tried with
noapic, but it didn't change. I have reduced the TCQ from 253 to 32, and I
had the impression that it was more difficult to trigger, although I cannot
be certain. With 32, I could boot and go to about half the 'make -j 8 dep',
while it hanged during init script with 253. I may retest by the week-end, but
now I'm going to sleep. Now I'm back to 6.2.28 and everything's OK.

Regards,
Willy

