Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbTLaSEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 13:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbTLaSEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 13:04:52 -0500
Received: from rat-3.inet.it ([213.92.5.93]:31923 "EHLO rat-3.inet.it")
	by vger.kernel.org with ESMTP id S265203AbTLaSEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 13:04:50 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: 2.6.1-rc1 [resend]
Date: Wed, 31 Dec 2003 19:03:56 +0100
User-Agent: KMail/1.5.2
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org> <200312311645.23348.ornati@lycos.it> <3FF2F9FE.2000403@wmich.edu>
In-Reply-To: <3FF2F9FE.2000403@wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312311903.56832.ornati@lycos.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 December 2003 17:31, Ed Sweetman wrote:
> Paolo Ornati wrote:
> > On Wednesday 31 December 2003 16:20, you wrote:
> >>On Wednesday 31 December 2003 16:06, you wrote:
> >>>>What io scheduler are you using? Or, could you post /var/log/dmesg?
> >>
> >>On Wed, Dec 31, 2003 at 04:19:27PM +0100, Paolo Ornati wrote:
> >>>"dmesg" and "config" attached.
> >>
> >>Could you try this with elevator=deadline?
> >
> > ok, I have just tried...
> > I don't see any big difference.
>
> Wasn't it mentioned in another thread related to a drop in ide
> performance that there is possibly some bug in the ide code that ends up
> requiring you to set the readahead on all your devices to see the max
> performance of any one?
>
> set all the readaheads of all your ide devices to 8192  You should see
> the best peformance doing this.

No, I have just try it but I don't see any changes.

My question is about a strange change of "behaviour" in IDE performance 
changing readahead.

Here I report a new thing that I've noticed today:

Kernel 2.6.0:

o readahead up to 224:
when I run "hdparm -t /dev/hda" the HD LED light up... and after a while 
light down

o readahead > 224:
running "hdparm" the HD LED starts blinking... and then light down

The best performance are riched with values between 128 and 224 --> IOW when 
the HD led starts blinking the performance diminish...


Kernel 2.6.1-rc1:

the HD LED starts to blink with readahead = 16 !!!
Why?


BYE

-- 
	Paolo Ornati
	Linux v2.6.0

