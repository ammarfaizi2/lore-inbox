Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965652AbWKIUlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965652AbWKIUlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965754AbWKIUlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:41:39 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:8372 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965652AbWKIUli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:41:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=h+ArFCvkpYjEanxJOj4eyw6I+IThaRqz/mDMTwLfPFn6nNACm4XbS2HocAjKmRnOsLQGsRINasF+634ttObzUmOv7iSx4TYzfq53vzY27BtEVj7bpe97kN8XrGNakRzV3t6jXMcV73ieUUvIkZJLnjBWdz5fMwYxPY3r4DB1Rdk=  ;
Date: Thu, 09 Nov 2006 12:41:31 -0800
From: David Brownell <david-b@pacbell.net>
To: andrew@sanpeople.com
Subject: Re: [Bulk] Re: [-mm patch 1/4] GPIO framework for AVR32
Cc: linux-kernel@vger.kernel.org, hskinnemoen@atmel.com, akpm@osdl.org
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
 <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
 <20061107131014.535ab280.akpm@osdl.org>
 <20061107223741.62FA21DC801@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
 <20061108124823.308ae3b4@cad-250-152.norway.atmel.com>
 <20061108180059.845DE1DC95A@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
 <1163057161.14573.180.camel@fuzzie.sanpeople.com>
In-Reply-To: <1163057161.14573.180.camel@fuzzie.sanpeople.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061109204131.E49241DA30B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We originally had at91_set_gpio_direction() in the AT91 GPIO layer, and
> that seemed to cause confusion  (eg, do I pass a 1 or 0 to enable output
> mode?)

I was thinking the __bitwise annotation on GPIO_IN and GPIO_OUT should
address that problem, but for some reason it isn't doing that.  I must
be doing something wrong; even "sparse" isn't warning when passing a
bogus parameter.


> So I'd personally prefer to keep gpio_set_input() and
> gpio_set_output().  (alternative is "enable" instead of "set").
> I think it's more readable.

To be clear ... having two different function calls is a brand
new proposal.  :)

Agreed on readable, and I do recall the problem.  If I can't get
the __bitwise annotation to behave, that's how I'll do it.

- Dave


