Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292466AbSBUPlo>; Thu, 21 Feb 2002 10:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292465AbSBUPlf>; Thu, 21 Feb 2002 10:41:35 -0500
Received: from dsl-65-188-226-101.telocity.com ([65.188.226.101]:26633 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S292464AbSBUPl1>; Thu, 21 Feb 2002 10:41:27 -0500
Date: Thu, 21 Feb 2002 10:41:23 -0500
From: Jason Lunz <j@trellisinc.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
Message-ID: <20020221154123.GA6543@trellisinc.com>
In-Reply-To: <Pine.LNX.4.44.0202210636020.8696-100000@dlang.diginsite.com> <3C750CCF.989B1FDD@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C750CCF.989B1FDD@mandrakesoft.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> David Lang wrote:
>> I'll argue that _not_ doing this violated the principle of lease surprise,
>> if you turn a feature on and immediatly back off why should anything in
>> your config be any different then it was before you turned it on?
> 
> Imagine this case:
> 
> make xconfig # select CONFIG_USB_HID, which auto-selects CONFIG_INPUT
> { time passes }
> make xconfig # de-select CONFIG_USB_HID
> 
> On the second 'make xconfig', should CONFIG_INPUT be automatically
> de-selected?  No.  Because that is making the assumption that the person
> does not want to continue to make the input API available.

It depends. When CONFIG_USB_HID auto-selected CONFIG_INPUT, did the user
know about it? Or did it just happen automagically behind the scenes? If
it was turned on silently, and the subsequent de-select of
CONFIG_USB_HID silently left CONFIG_INPUT turned on, I'd say that
violates least-surprise.

On the other hand, if turning on CONFIG_USB_HID then prompts "to do
that, I also have to turn on CONFIG_INPUT", i suppose it's ok to leave
CONFIG_INPUT turned on later.

-- 
Jason Lunz		Trellis Network Security
j@trellisinc.com	http://www.trellisinc.com/
