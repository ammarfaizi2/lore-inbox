Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTJSIgS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTJSIgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:36:18 -0400
Received: from holomorphy.com ([66.224.33.161]:55424 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262101AbTJSIgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:36:16 -0400
Date: Sun, 19 Oct 2003 01:35:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Larry McVoy <lm@bitmover.com>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
       Justin Cormack <justin@street-vision.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vitaly Fertman <vitaly@namesys.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       axboe@suse.de
Subject: Re: Blockbusting news, results are in
Message-ID: <20031019083551.GA1108@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hans Reiser <reiser@namesys.com>, Larry McVoy <lm@bitmover.com>,
	Norman Diamond <ndiamond@wta.att.ne.jp>,
	Wes Janzen <superchkn@sbcglobal.net>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
	nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
	Justin Cormack <justin@street-vision.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Vitaly Fertman <vitaly@namesys.com>,
	Krzysztof Halasa <khc@pm.waw.pl>, axboe@suse.de
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60> <20031019041553.GA25372@work.bitmover.com> <3F924660.4040405@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F924660.4040405@namesys.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
>> I've told you guys over and over that you need to CRC the data in user
>> space, we do that in our backup scripts and it tells us when the drives
>> are going bad.  S

On Sun, Oct 19, 2003 at 12:08:00PM +0400, Hans Reiser wrote:
> Why do the CRC in user space, that requires modifying every one of 7000+ 
> applications (if I understand you correctly, which is far from a sure 
> thing;-) )?
> Write a reiser4 CRC file plugin.  It would take a weekend, and most of the 
> work would be cut and pasting from the default file plugin..  
> I understand why you do it in BK, but for user space as a whole user space 
> is the wrong place.

I think the fs driver layer might be the wrong thing too; maybe it'd be
best to do the CRC and/or checksumming at the block layer?

At the very least, I see a lack of genericity with respect to making it a
plugin to a specific fs. I'm going to try not to delve too far into
specifics, as my knowledge in these areas is limited, but I'd welcome any
corrections of misunderstandings I might have about feasibility, value,
or importance of these things, and even techhical misconceptions.

Jens, I apologize if advance if this is just another lame flamewar best
bitbucketed as opposed to answered.

Thanks.


-- wli
