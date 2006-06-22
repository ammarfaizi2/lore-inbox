Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWFVQ6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWFVQ6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWFVQ6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:58:09 -0400
Received: from web33303.mail.mud.yahoo.com ([68.142.206.118]:17775 "HELO
	web33303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751226AbWFVQ6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:58:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oqHzTLEsF9uWwzpRArRBDUHHX9Yk9ObI6+lNfWf0U13LwTt7Rl8XjT3HAA8BAh6Khm15U+SNAiaxiLvGTAQtmtoD+6P1YTNmuBuGfPvOqNEFICVdkWBnkCc9jYw6Rccbd+nMlX1iO0dGi9DAqwofHAZQ/A6yvsgCI87ydzIHiDY=  ;
Message-ID: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
Date: Thu, 22 Jun 2006 09:58:08 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Measuring tools - top and interrupts
To: linux-kernel@vger.kernel.org
In-Reply-To: <20060622162141.GC14682@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Erik Mouw <erik@harddisk-recovery.com> wrote:

> On Thu, Jun 22, 2006 at 08:26:21AM -0700,
> Danial Thom wrote:
> > Running 2.6.17, it seems that top is
> reporting
> > 100% idle with a network load of about 75K
> pps
> > (bridged) , which seems unlikely. Is it
> possible
> > that system load accounting is turned off by
> some
> > tunning knob?
> 
> 75K packets/s isn't too hard for modern NICs,
> especially when using
> NAPI.

Well thats just a ridiculous answer, so why
bother? 

You polling guys just crack me up. There isn't
much less work to be done with polling. The only
reason you THINK its less work is because the
measuring tools don't work properly. You still
have to process the same number of packets when
you poll, and you have polls instead of
interrupts. Since you can control the # of
interrupts with most cards, there is zero
advantage to polling, and more negatives.

And 75K pps may not be "much", but its still at
least 10% of what the system can handle, so it
should measure around a 10% load. 2.4 measures
about 12% load. So the only conclusion is that
load accounting is broken in 2.6.

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
