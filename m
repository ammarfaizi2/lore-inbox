Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTJ1BWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTJ1BWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:22:13 -0500
Received: from gprs192-78.eurotel.cz ([160.218.192.78]:6273 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263806AbTJ1BWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:22:11 -0500
Date: Tue, 28 Oct 2003 02:21:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hans Reiser <reiser@namesys.com>, "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results get worse
Message-ID: <20031028012143.GA427@elf.ucw.cz>
References: <785F348679A4D5119A0C009027DE33C105CDB3B0@mcoexc04.mlm.maxtor.com> <3F9D6891.5040300@namesys.com> <3F9D7666.6010504@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9D7666.6010504@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>or put it under heavy write workload and remove
> >>power.
> >>
> >Can you tell us more about what really happens to disk drives when the 
> >power is cut while a block is being written?  We engage in a lot of 
> >uninformed speculation, and it would be nice if someone who really knows 
> >told us....
> >
> >Do drives have enough capacitance under normal conditions to finish 
> >writing the block?  Does ECC on the drive detect that the block was bad 
> >and so we don't need to detect it in the FS?
> 
> 
> Does it really matter to speculate about this?
> 
> If you don't FLUSH CACHE, you have no guarantees your data is on the 
> platter.

Well, even without FLUSH CACHE, you can expect that sector being
writen during powerfail either contains old data *or* new data.

If sector can become unreadable after powerfail, I guess journaling
people would like to know, and if powerfail may mean adjacent (or even
unrelated?) sectors to be damaged, everyone needs to know...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
