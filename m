Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTJLSxH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 14:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTJLSxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 14:53:07 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:38843 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263505AbTJLSxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 14:53:05 -0400
Message-ID: <3F89A4AD.2020808@pacbell.net>
Date: Sun, 12 Oct 2003 11:59:57 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Peter Matthias <espi@epost.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: ACM USB modem on Kernel 2.6.0-test
References: <3F8851A7.3000105@pacbell.net> <20031012120734.GE13427@mail.shareable.org>
In-Reply-To: <20031012120734.GE13427@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> David Brownell wrote:
> 
>>Hmm ... maybe usbcore would be better off with a less
>>naive algorithm for choosing defaults.  Like, preferring
>>configurations without proprietary device protocols.
>>That'd solve every cdc-acm case, and likely others.
> 
> 
> Presumably 2.4 does that, because my acm modem works with 2.3 and 2.4
> kernels.

No, 2.4 is just as dumb -- but it had a way to kluge around
that.  But that kluge doesn't work any more on 2.6, mostly
because usb_set_configuration() now behaves sanely.  (Not
only does it shut down the old configuration ... but it also
sets up the new one correctly.)

Your modem should work just fine with 2.6 too, if you just
switch to the other configuration from userspace.  However,
I'd certainly like to reduce the need for such steps.


> Do you know anything about the proprietary protocols, btw?

My understanding is that knowing technical details involves
signing NDAs with MSFT.  But I've not investigated much;
likely other people know more.

- Dave



