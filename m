Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTJQB7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbTJQB7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:59:20 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:42148 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263290AbTJQB7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:59:19 -0400
Date: Thu, 16 Oct 2003 18:59:12 -0700
From: Larry McVoy <lm@bitmover.com>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031017015912.GA28158@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017013245.GA6053@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017013245.GA6053@ncsu.edu>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 09:32:45PM -0400, jlnance@unity.ncsu.edu wrote:
> Lots of machines dont have ECC ram and seem to work reasonably well.

That's because you have two choices in RAM today: ECC and straight memory,
no parity.  So you never know that there is a problem until /bin/ls starts
core dumping.

BK users catch memory errors all the time because BK checksums the data.
Even with a very (!) weak checksum we see it (we have retained, perhaps
stupidly, backwards compat with SCCS' 16 bit checksum - not CRC).  One
nice thing about the weak checksum is that we can tell if it is a memory
from looking at the got/wanted values for the checksum, single bit errors
are obvious.  It happens so frequently that we have learned to recognize
it and tell the customer within seconds of getting the mail.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
