Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVB1QFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVB1QFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVB1QFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:05:13 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:15494 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261665AbVB1QFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:05:07 -0500
X-Envelope-From: kraxel@bytesex.org
To: James Bruce <bruce@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
References: <422001CD.7020806@andrew.cmu.edu> <20050228134410.GA7499@bytesex>
	<42232DFC.6090000@andrew.cmu.edu>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 28 Feb 2005 17:02:03 +0100
In-Reply-To: <42232DFC.6090000@andrew.cmu.edu>
Message-ID: <87mzto3c78.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce <bruce@andrew.cmu.edu> writes:

> Well, are there any theories as to why it would work flawlessly, then
> after a hard lockup (due to what I think is a buggy V4L2 application),
> that the cards no longer work?

No idea why the eeprom doesn't respond any more.  Maybe it's really
broken.  Note that the eeprom is read only at insmod time (and even
that for some cards only), thus there isn't a clear connection between
the crash and the eeprom issue.  It could have died earlied unnoticed.

The eeprom holds the PCI Subsystem ID, so without a working eeprom
bttv can't figure automatically what exact card that is (see the
"unknown/default" card name in the log) and maybe thats why does not
work any more for the card in question.  Thats should be easily
fixable using the card= insmod option.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
