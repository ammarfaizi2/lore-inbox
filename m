Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTDOMhu (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTDOMhu 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:37:50 -0400
Received: from zork.zork.net ([66.92.188.166]:47341 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261326AbTDOMht 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:37:49 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: BUGed to death
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: ARGUMENTUM AD HOMINEM, DISCLOSURE OF
 TRADE SECRET(S)
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 15 Apr 2003 13:49:39 +0100
In-Reply-To: <20030415123134.GM9776@suse.de> (Jens Axboe's message of "Tue,
 15 Apr 2003 14:31:34 +0200")
Message-ID: <6uwuhw0vto.fsf@zork.zork.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <80690000.1050351598@flay>
	<200304151401.00704.baldrick@wanadoo.fr>
	<20030415123134.GM9776@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Tue, Apr 15 2003, Duncan Sands wrote:
>> On Monday 14 April 2003 22:19, Martin J. Bligh wrote:
>> > Seems all these bug checks are fairly expensive. I can get 1%
>> > back on system time for kernel compiles by changing BUG to
>> > "do {} while (0)" to make them all compile away. Profiles aren't
>> > very revealing though ... seems to be within experimental error ;-(
>> 
>> What happens if you just turn BUG_ON into "do {} while (0)"?
>
> If you do that, you must audit every single BUG_ON to make sure the
> expression doesn't have any side effects.
>
> 	BUG_ON(do_the_good_stuff());

#define BUG_ON(x) x; do the trick.  With any luck the compiler will
throw away most of the simple comparisons and whatnot.

-- 
Sean Neakums - <sneakums@zork.net>
