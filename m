Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWFJW1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWFJW1g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWFJW1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:27:36 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:8666 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1161040AbWFJW1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:27:35 -0400
Date: Sun, 11 Jun 2006 01:27:34 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: VGER does gradual SPF activation  (FAQ matter)
Message-ID: <20060610222734.GZ27502@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is even an RFC published about SPF...


What is SPF ?

It is one way to to ensure that at SMTP transport level the claimed
message source domain is valid, and message is coming from place
where origination domain's administrator has declared that are valid
source servers for emails claiming to be of that domain.


It does NOT verify that SMTP origination local part is true. 

It does NOT verify message visible headers.

Several people have written MTA configurations that test arriving email
visible "From:" (and sometimes "Sent:") header against SPF data and
actually violate SPF specification doing that!
(We have routinely kicked subscribers with that bug from lists..)


What it gives ?

It gives us a way to tell the world, that emails claiming to be
coming from VGER should be accepted only when they really are
coming from vger. (Complications like recipients incoming MX
relays are not _our_ problem..)

We might get slight reduction of back falling junk at vger with
that - reduction increases when people begin to deploy the SPF
verification more and more widely into their receiving email servers.
(And do it correctly...)



Will VGER begin to verify SPF in incoming email ?

Yes, sometime this summer.



What will break ?

You really should go and read SPF documents and guides and FAQs at:
    http://spf.pobox.com/

Very little will break, but one should really consider converting
their email sending methodology to one, which uses fewest possible
number of servers, publish that data in DNS, and always send all
emails thru those servers.

In longer run the amount of irresponsible (incurable) network security
holes (known as Windows) shows no sign of becoming extinct at adsl -lines,
so there will be increased pressure to demand sender identification
(and verification) during email sending - viruses can't do that yet...
And when they learn, user with infection can be trivially identified
and contacted/blocked.  At the same time I do find it most likely that
ADSL-lines (and modems) will no longer be allowed to send _anywhere_
over plain SMTP.

In order to be able to send email, a "SUBMISSION" protocol does exist,
and is relatively easy to get working with for example the Thunderbird.
Better would be having a button "use submission service" in its account
setup..   (And similar in Outlook/O.Express...)


/Matti Aarnio -- one of  postmaster at vger.kernel.org
