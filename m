Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264392AbRFGKpm>; Thu, 7 Jun 2001 06:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264394AbRFGKpc>; Thu, 7 Jun 2001 06:45:32 -0400
Received: from mail.zmailer.org ([194.252.70.162]:19722 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S264392AbRFGKpY>;
	Thu, 7 Jun 2001 06:45:24 -0400
Date: Thu, 7 Jun 2001 13:45:12 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: ADMIN: The plague of ill-defined content filters...
Message-ID: <20010607134512.X5947@mea-ext.zmailer.org>
Reply-To: Matti Aarnio <matti.aarnio@zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ If you want to comment about this topic, respect the Reply-To ! ]


The last week or so has seen a profileration of email bounces during
the mail delivery, or "DATA" phase.

I can somewhat sympathise the goals of the filters, but some are quite
unfathomable of how they decide what exact content is undesirable, and
what isn't...

The most common ill-defined filters seem to essentially grep for a sequence
of characters anywhere in the message body without paying attention to such
small details as if that character sequence forms a word, or is part of some
other word.

Example (obfuscated against stupid grep):

      the   l i n k   to ...

It was matched against:

              i n k

Right, definitely the same thing, isn't it ?

Better filters look for longer character sequences, possibly even detecting
word separators.

At the end of the page:
    http://vger.kernel.org/majordomo-info.html
you can see how VGER filters through-going traffic -- "Taboo things"...
That thing works so well, that rarely anything truly spammish goes thru.
Senders of such messages don't get any notification at all.
(In case the message is e.g. too large, they get a word that it has been
 diverted to Approval.)


Best filters give parametrizable amounts of points to found matches, some
may be harmless enough to exist elsewere, while others are dead give-aways
of spam.   When the message accumulates high enough treshold value of such
points, it can fairly certainly be classified as spam.

Best sites let at least system postmaster receive anything without it
being filtered -- I have seen cases where big corporate input filter says
in its reject message that "do contact  'filtops@...' if you   t h i n k
something is wrong...", and when I send the exact message there, it bounces...


So,  if you all the sudden loose your subscription, it could be just
because your ISP decided that a 3 character sequence anywhere in the
message body is a sign of spam.



/Matti Aarnio   co-postmaster of vger.kernel.org
