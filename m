Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTFBPcN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTFBPcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:32:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7655
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262458AbTFBPcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:32:12 -0400
Subject: Re: impact of Athlon's slower front-side-bus (FSB)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200306020947.44520.jbriggs@briggsmedia.com>
References: <200306020947.44520.jbriggs@briggsmedia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054565258.7494.34.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 15:47:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-02 at 14:47, joe briggs wrote:
> The fastest AMD single processor Athlon XP is 3200 with 400 Mhz FSB.
> The fastest AMD dual processor Athlon MP is 2800 but with only 266 Mhz FSB.
> 
> So, for a multimedia application, which platform would be faster?  How does 
> the much slower FSB of the dual processor impact its ability to grab and 
> crunch.  Does its onboard cache make the slower speed FSB less important?  

Its really hard to tell. The 3200 has a bigger cache too if I remember
rightly. If you are planning on buying big boxes for this you might want
to ask the vendor if you can do a test run or two.

> Also, does a dual processor platform distribute the interrupt loading as well 
> as process loading?  I my systems I have between 1 and 8 frame identical 
> frame grabbers.  Would the interrupt processing of these devices be 
> distributed evenly on the dual processor platforms?

Yes. You would probably want to tie different cards/encoders to
different processors and the IRQ to the same one. You can do this via
/proc and with the -ac or most vendor trees (and 2.5) you can tie
processes to CPUs with syscalls

