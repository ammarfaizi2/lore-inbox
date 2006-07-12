Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWGLBJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWGLBJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 21:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWGLBJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 21:09:38 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31634
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932334AbWGLBJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 21:09:37 -0400
Date: Tue, 11 Jul 2006 18:10:01 -0700 (PDT)
Message-Id: <20060711.181001.11575463.davem@davemloft.net>
To: thinkinginbinary@gmail.com
Cc: linux-kernel@vger.kernel.org, dl8bcu@dl8bcu.de, alon.barlev@gmail.com,
       s0348365@sms.ed.ac.uk, linville@tuxdriver.com, joesmidt@byu.net
Subject: Re: Will there be Intel Wireless 3945ABG support?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060712004212.GA26712@phoenix>
References: <44B3ED29.4040801@gmail.com>
	<20060711201615.GB11871@Marvin.DL8BCU.ampr.org>
	<20060712004212.GA26712@phoenix>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Tuttle <thinkinginbinary@gmail.com>
Date: Tue, 11 Jul 2006 20:42:12 -0400

> Frankly, I'm annoyed that, if Intel understood the full extent of the
> problem, that they didn't take a better approach and simply give the
> card a set of legal values.  It doesn't need to understand the
> subtleties of what they mean.  It just needs to know frequencies 1, 2,
> and 3 are okay, but not 4, 5, and 6, and that the max power is xx dBm.

You miss many important issues in your diatribe.  I don't like the
situation either, but I hold this position understanding the
conditions (both technical and legal) under which companies such as
Atheros and Intel must operate.

First off, the reason these radios are fully programmable, not fixed
in on-board firmware or likewise, is so that people doing "special
stuff" outside the normal operating frequencies and power levels, and
have a license to do so, can use these wireless chips out of the box.
Otherwise custom boards would need to be produced and that is
prohibitively expensive and restrictive for what some of these
folks want to do.

Such companies can thus provide firmware or drivers that operate
within a customer's specially licensed frequency or power range once
that customer proves they do indeed have a license from the FCC to use
it.

Secondarily, it is up to lawyers, not you, to decide what is a safe
manner for the maker of a wireless chipset to abide by the FCC
regulations.  And across the board, lawyers representing these
companies and other entities seem to agree that providing the full
source code to a wireless chip driver's radio programming makes
it "user-modifiable", whereas hiding the radio programming behind
a binary-only blob or firmware satisfies the FCC requirements.

And if you think they haven't invested any effort to look into
alternatives that will satisfy both the FCC and the open source crowd,
think again.  You can be sure they've spent a lot of time thinking
about how to deal with this.  It is absurd to say things which suggest
that these guys are sitting around twiddling their thumbs about the
issue, and think the current state of affairs is ok.

It's not a matter of "impossible" vs. "possible" to modify the
frequencies and power levels outside of the allowed range, rather it's
a matter of making it "difficult enough" for an end user to modify
these restrictions.

As long as it's Intel's or Atheros's ass that gets reamed by the FCC
for running afoul of the radio frequency regulations, they will not be
posting the source code to program their radios.  On the other hand,
if it happens to get legally reverse engineered, then unless these
companies assisted in that reverse engineering effort, the FCC really
couldn't go after them.  Such companies would also not be able to
participate in maintainence of a driver for their chips containing
the reverse engineered components.  However, we've dealt with that
kind of situation just fine in the past :)

So we will be in this endless loop finding ways to legally reverse
engineer binary blobs to get fully free wireless drivers, until the
FCC regulation situation is rectified.
