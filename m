Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUHJW4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUHJW4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267803AbUHJW4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:56:40 -0400
Received: from digitalimplant.org ([64.62.235.95]:13790 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S267799AbUHJW4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:56:20 -0400
Date: Tue, 10 Aug 2004 15:56:10 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "" <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <1092176983.2709.3.camel@laptop.cunninghams>
Message-ID: <Pine.LNX.4.50.0408101544470.28789-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> 
 <20040809113829.GB9793@elf.ucw.cz>  <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
  <20040809212949.GA1120@elf.ucw.cz>  <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
  <1092130981.2676.1.camel@laptop.cunninghams> 
 <Pine.LNX.4.50.0408100655190.13807-100000@monsoon.he.net>
 <1092176983.2709.3.camel@laptop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Aug 2004, Nigel Cunningham wrote:

> I'm not intending to patch the current implementation into the new
> version; there are so many changes that it would make the process
> extremely painful (as evolution would have been if it were really true).
> Instead, I proposed, as Andrew requested to post a number of patches
> simply adding the new version along side the old. When you're satisfied
> that the new does everything the old does, I'm hoping we'll simply drop
> the old version.

Then there is something seriously wrong with your development process.

I'm sorry, but that's not how it works. There is no "flag day" for
switching from one feature to the next, whether they are drivers, APIs, or
suspend-to-disk implementations. And, I will definitely say, from
experience, that adding a second competing implementation of anything to
the kernel tree does little more than confuse users and developers.

Making large changes to any piece of code is a long and tedious process,
and takes a lot of practice. But, it is imperative for the other people
working on it to be able to see improvements happen in steps, even if the
steps number in the 100s.

For example, see the way in which Al Viro works. One day, some driver will
be broken and unloved. Then Al will post a kajillion patches, each one
modifying 1-10 lines and making complete, obvious sense. When it's all
done, the result looks nothing like the original and the driver is
race-free and beautiful.

Rome was not built in a day, and neither is good kernel code.


	Pat
