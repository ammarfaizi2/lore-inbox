Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVHCVPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVHCVPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVHCVPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:15:39 -0400
Received: from 81-5-177-201.dsl.eclipse.net.uk ([81.5.177.201]:21253 "EHLO
	hades.smop.co.uk") by vger.kernel.org with ESMTP id S261156AbVHCVPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:15:37 -0400
Date: Wed, 3 Aug 2005 22:15:27 +0100
To: linux-kernel@vger.kernel.org
Subject: buglet reading /proc/ide/(cdrom)/capacity
Message-ID: <20050803211527.GA20575@wyvern.smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Adrian Bridgett <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.899,
	required 5, autolearn=not spam, ALL_TRUSTED -3.30, BAYES_00 -2.60)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a minor buglet I've noticed /proc/ide/hdc/cdrom (where hdc is my
CDROM drive - Liteon 52x32x52).

If I cat this file while inserting the CDROM the command hangs, then
returns 304912 (fine).

If I insert a CDROM, then wait a while (say 30 seconds), then
it returns 304912 (also fine).

However if I insert a CDROM, then wait until the light stops flashing
(5 seconds) then I get: "0\n4912"  like this:

cat //proc/ide/hdc/capacity | od -c
0000000   0  \n   4   9   1   2  \n

I've checked with another CD and it is the first two characters being
overwritten.

PS: I'm not currently subscribed to the list, so please Cc me.  

Thanks,

Adrian
-- 
Email: adrian@smop.co.uk  -*-  GPG key available on public key servers
Debian GNU/Linux - the maintainable distribution   -*-  www.debian.org
Avoid working with children, animals and Microsoft "operating" systems
