Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbVIMPGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbVIMPGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVIMPGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:06:05 -0400
Received: from 216-54-166-16.gen.twtelecom.net ([216.54.166.16]:23256 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S932663AbVIMPGE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:06:04 -0400
Message-ID: <4326EAD7.50004@compro.net>
Date: Tue, 13 Sep 2005 11:05:59 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: HZ question
References: <4326CAB3.6020109@compro.net> <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com> <4326DB8A.7040109@compro.net> <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.12.33
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
> On Tue, 13 Sep 2005, Mark Hounschell wrote:
> 
>>Most if not all userland delay calls rely on HZ value in some way or
>>another. The minimum reliable delay you can get is one (kernel)HZ. A
>>program that needs an acurrate delay for a time shorter that one
>>(kernel)HZ may have an alternative if it knows that HZ is greater the
>>the requested delay.
> 
> Just assume that kernel HZ are USER_HZ and see anything else as an
> additional bonus that you cannot rely on.
> 
> What does 'acurrate delay' mean, anyways?
> 
> Tim
> 

But they are not the same. Why can I get USER_HZ but not HZ?


On a 100HZ kernel ANY requested delay via udelay or 
pthread_cond_timedwait of less than 10000usecs is unreliable and the the 
actual results are totally unacceptable.

On a 1000HZ kernel the number is 1000 usecs.

I'm not asking the kernel running at 1000hz to actually give me 500 usec 
delay if I ask. I do expect it to be at least 500 usec and within +- a 
single HZ however. Oviously a 1000HZ machine is going to give me better 
resulution in any requested delay. Why is it unreasonable for userland 
to know the probable resolution of userland delay requests.

For those required delays less than a HZ I have alternatives that are 
more accruate than += one HZ. I just need to know the kernel HZ in order 
to better predict when my alternative methods will be prefered.


Mark
