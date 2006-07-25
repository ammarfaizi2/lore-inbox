Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWGYV31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWGYV31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWGYV30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:29:26 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:22447 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S964863AbWGYV30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:29:26 -0400
Date: Tue, 25 Jul 2006 14:28:34 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Matthias Andree <matthias.andree@gmx.de>
cc: Arjan van de Ven <arjan@infradead.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
In-Reply-To: <20060725212001.GA5493@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.63.0607251420350.9159@qynat.qvtvafvgr.pbz>
References: <20060725034247.GA5837@kroah.com>  <m33bcqdn5y.fsf@anduin.mandriva.com>
  <200607251123.40549.adq_dvb@lidskialf.net>  <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz>
  <1153846619.8932.36.camel@laptopd505.fenrus.org> <20060725212001.GA5493@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, Matthias Andree wrote:

> On Tue, 25 Jul 2006, Arjan van de Ven wrote:
>
>> well you can do such a thing withing statistical bounds; however... if
>> the patch already is in -git (as is -stable policy normally).. it should
>> have been found there already...
>
> The sad facts I learned from Debian bug #212762 (not kernel related) that
> culminated in CVE-2005-2335 (remote root exploit against older
> fetchmail) and from various qmail bugs Guninski discovered:
>
> - a bug need not necessarily be found soon after introduction
>
> - a bug report may not convey the hint "look at this NOW, the shit
>  already hit the fan"
>  (sorry, I meant to write: look NOW, it's urgent and important)
>
> - an automated test to catch non-trivial mistakes is non-trivial in
>  itself, and - what I've seen with another project I was involved with,
>  and more often than I found amusing - is that the test itself can be
>  buggy causing bogus results.
>
> That doesn't mean I object to automated tests, but "it should have been
> found by now" (because the source is open, someone could have tested it,
> whatever) just doesn't work.

what I was intending with my origional question was a series of simple 'does it 
compile' tests that try all the config options that are affected by the patchset 
in question. the purpose being to catch simple errors like the one here where 
the patch was diffed against the wrong tree and the result doesn't compile

i.e. if the change is the the e1000 driver, try compiling a kernel with it on, 
off, and as a module

obviously such a test can't be done on the huge -rc patches (they would approach 
an exhaustive test of all config permutations), but for -stable patches (or 
better still the indivdual patches that form a -stable release)

so the first part of the question boils down to

1. Given a patch that modifies file X is it possible to know what config options 
could be affected?

and the second part would be

2. would it make sense for the LTP or one of the big compile farms to do a 
series of compiles prior to the release of a -stable kernel to catch mistakes 
like this?

David Lang
