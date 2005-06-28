Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVF1N6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVF1N6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 09:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVF1N4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 09:56:04 -0400
Received: from [212.76.86.236] ([212.76.86.236]:37892 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261734AbVF1NwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 09:52:24 -0400
Message-Id: <200506281352.QAA25851@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Nix'" <nix@esperi.org.uk>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Kswapd flaw
Date: Tue, 28 Jun 2005 16:52:00 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <87irzy63xx.fsf@amaterasu.srvr.nix>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV7333k46W3g0dLQ5miurYf15zZ8wAB8jqQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nix, how are you?
You wrote: {
On 28 Jun 2005, Al Boldi yowled:
> Nix wrote:
>> On 28 Jun 2005, Al Boldi murmured woefully:
>>> Kswapd starts evicting processes to fullfil a malloc, when it should 
>>> just deny it because there is no swap.
>> I can't even tell what you're expecting. Surely not that no pages are 
>> ever evicted or flushed; your memory would fill up with page cache in no
time.
> 
> Please do flush anytime, and do it in sync during OOMs; but don't 
> evict procs especially not RUNNING procs, that is overkill.

Would you really like a system where once something was faulted in, it could
never leave? You'd run out of memory *awfully* fast.
}

Nix,
You should only fault if you have a place to fault to, as into a swap.
Without swap faulting is overkill.

Is it possible to change kswapd's default behaviour to not fault if there is
no swap?

Thanks!

