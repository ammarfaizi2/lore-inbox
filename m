Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTJZJla (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 04:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTJZJla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 04:41:30 -0500
Received: from gprs195-16.eurotel.cz ([160.218.195.16]:3457 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262986AbTJZJl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 04:41:28 -0500
Date: Sun, 26 Oct 2003 10:41:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John Bradford <john@grabjohn.com>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org, nikita@namesys.com,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results get worse
Message-ID: <20031026094103.GC293@elf.ucw.cz>
References: <334101c39b94$268a0370$24ee4ca5@DIAMONDLX60> <200310261039.h9QAdniV000310@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310261039.h9QAdniV000310@81-2-122-30.bradfords.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 4.  When writing ZEROES to the bad sector, the drive reports SUCCESS.
> > But it lies.  Subsequent attempts to read still fail.  Subsequent writing of
> > zeroes appears to succeed again.  Subsequent attempts to read still fail.
> 
> > I still have to say, we can't fix Toshiba, and we can avoid Toshiba, but
> > meanwhile we can fix Linux.
> 
> How do you suggest we 'fix' 4, above, other than to flush the cache
> and verify each time a full sector of zeros is written to the disk?

Well,

	if (drive_is_toshiba())
		panic("Forward harddrive to nearest trashcan.\n");

during bootup?

Reporting sucess when it is not, is, umm, bad.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
