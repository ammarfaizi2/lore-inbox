Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUEJLxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUEJLxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 07:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264644AbUEJLxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 07:53:23 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:3087 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264643AbUEJLxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 07:53:21 -0400
Date: Mon, 10 May 2004 13:53:18 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Gabriel Paubert <paubert@iram.es>
Cc: Linus Torvalds <torvalds@osdl.org>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org
Subject: Re: get_cmos_time() takes up to a second on boot
Message-ID: <20040510115318.GA8632@wsdw14.win.tue.nl>
References: <409C2CBA.8040709@am.sony.com> <Pine.LNX.4.58.0405071908060.3271@ppc970.osdl.org> <20040510105230.GA14104@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510105230.GA14104@iram.es>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 07:15:53PM -0700, Linus Torvalds wrote:

>> These days, I think we do the write-back only if we use an external clock 
>> (NTP), so we probably _could_ just remove the synchronization at 
>> read-time (removing it at write-time doesn't sound like a good idea).
>>
>> I don't think we should necessarily disable the synchronization, but we
>> could certainly make it optional for cases that don't care about it. We
>> might even make the default be "don't care about the read
>> synchronization".

On Mon, May 10, 2004 at 12:52:30PM +0200, Gabriel Paubert wrote:

> I'm for one against dropping the synchronization and even making the
> default not to synchronize, I'd rather see this as an option under
> the embedded subset for the people who really want fast boot time.

There is hwclock that will read or write the CMOS clock,
and it synchronizes.

So if one wants to synchronize with the CMOS clock (rather than, say,
with an external clock), and wants the better-than-1-sec accuracy,
then that can be done in a boot script.

Andries

[I think everybody likes fast boot time.
Ah - 30 years ago my system booted in the fraction of a second
needed to print the command prompt.
Why have computers become so slow?]

