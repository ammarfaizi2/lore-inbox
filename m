Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWG3QcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWG3QcO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWG3QcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:32:14 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:39318 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932349AbWG3QcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:32:14 -0400
Date: Sun, 30 Jul 2006 17:32:03 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jan Dittmer <jdi@l4x.org>
Cc: Theodore Tso <tytso@mit.edu>, Kasper Sandberg <lkml@metanurb.dk>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw3945 status
Message-ID: <20060730163203.GA31495@srcf.ucam.org>
References: <20060730104042.GE1920@elf.ucw.cz> <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org> <20060730114722.GA26046@srcf.ucam.org> <1154264478.13635.22.camel@localhost> <20060730145305.GE23279@thunk.org> <44CCDD7E.3010207@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CCDD7E.3010207@l4x.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 06:25:34PM +0200, Jan Dittmer wrote:

> So if this is done, there should be a clearly abstracted interface
> for such a daemon. I don't see what the daemon is doing more than
> echo 1 4 7 8 > /sys/.../allowed_channels and a control circuit for
> tx/rx power.

The daemon sets the list of acceptable channels, the transmission powers 
for each of them and modifies this based on things like the temperature.

Oh, yes, and it writes 802.11 scan frames that get passed straight to 
the firmware and broadcast. Insane crack. For reasons I don't as yet 
understand, various received frames also get passed back up to the 
daemon. I probably really don't want to know why.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
