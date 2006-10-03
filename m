Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWJCKFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWJCKFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWJCKFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:05:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:29851 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964862AbWJCKFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:05:52 -0400
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and Nest Kernel Path?
Date: Tue, 3 Oct 2006 12:03:57 +0200
User-Agent: KMail/1.9.3
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Dong Feng <middle.fengdong@gmail.com>,
       Christoph Lameter <clameter@sgi.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com> <200609301703.45364.ak@suse.de> <20061003080352.GA4078@ucw.cz>
In-Reply-To: <20061003080352.GA4078@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610031203.57328.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 10:03, Pavel Machek wrote:
> On Sat 30-09-06 17:03:45, Andi Kleen wrote:
> > 
> > > Did you get to the bottom of this yet? It looks like you're right,
> > > and I suggest a seqlock might be a good option.
> > 
> > It basically doesn't matter because nobody changes the time zone after boot.
> 
> Attacker might; in a tight loop, to confuse time-of-day subsystem, or
> maybe oops the kernel.

(a) only root change it.
(b) the time of day subsystem never cares about the time zone. It is 
just a variable stored for user space.

-Andi
