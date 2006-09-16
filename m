Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWIPFDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWIPFDf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 01:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWIPFDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 01:03:35 -0400
Received: from ppp18-238.lns2.syd7.internode.on.net ([59.167.18.238]:35088
	"EHLO lucretia.isay.com.au") by vger.kernel.org with ESMTP
	id S1751421AbWIPFDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 01:03:34 -0400
Date: Sat, 16 Sep 2006 15:03:31 +1000
To: linux-kernel@vger.kernel.org
Subject: Repeatable hang on boot with PCMCIA card present
Message-ID: <20060916050331.GA6685@lucretia.remote.isay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: tarka@internode.on.net (Steve Smith)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I sent the following to the person responsible for the patch but
haven't heard anything so I assume he's unavailable...]

Hi,

With recent kernel releases I have started seeing consistent hangs
during boot when a PCMCIA card is present in the slot (the card in
question is a Linksys wireless-B card).  The symptoms are:

    If the card is present during boot an error of "Unknown interrupt
    or fault at EIP ..." appears.

    If the card is not present there is no error.

    The card can be plugged-in post-boot without problems.

Using git-bisect I have narrowed down the error to one commit, namely
"use bitfield instead of p_state and state".  The commit# is

    e2d4096365e06b9a3799afbadc28b4519c0b3526

However I am still seeing this problem with the latest -RC releases.

Additional information:

   Machine: Dell Inspiron 8100
   Distribution: Ubuntu Dapper

Please let me know if you need any more information.

Regards,
Steve Smith
