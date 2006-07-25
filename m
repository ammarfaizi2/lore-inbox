Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWGYTTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWGYTTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWGYTTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:19:13 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:46555
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964826AbWGYTTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:19:11 -0400
Message-ID: <44C66D1C.7010903@microgate.com>
Date: Tue, 25 Jul 2006 14:12:28 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-stable <stable@kernel.org>
Subject: Re: [stable] Success: tty_io flush_to_ldisc() error message triggered
References: <200607221209_MC3-1-C5CA-50EB@compuserve.com> <44C25548.5070307@microgate.com> <20060725184158.GH9021@kroah.com>
In-Reply-To: <20060725184158.GH9021@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Jul 22, 2006 at 11:41:44AM -0500, Paul Fulghum wrote:
> 
>>Chuck Ebbert wrote:
>>
>>>The cleaner fix looks more intrusive, though.
>>>
>>>Is this simpler change (what I'm running but without the warning
>>>messages) the preferred fix for -stable?
>>
>>It fixes the problem.
> 
> 
> So do you feel this patch should be added to the -stable kernel tree?

No. Now that I think about it, adding that extra
macro is just wrong even if temporary.

The real fix is equally simple, but in 2.6.18-rc
it is intertwined with other more intrusive changes.

Let me make a new separate patch that does things
the right way, which is simply removing the list
head while processing the list so two instances
to not trip over each other. I would have done so
earlier, but I've been insanely busy with multiple
work related deadlines (lame excuse I know).

I should post something tomorrow afternoon.

-- 
Paul Fulghum
Microgate Systems, Ltd.
