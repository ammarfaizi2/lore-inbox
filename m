Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424357AbWKJFoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424357AbWKJFoO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 00:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424358AbWKJFoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 00:44:14 -0500
Received: from web31502.mail.mud.yahoo.com ([68.142.198.131]:59534 "HELO
	web31502.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1424357AbWKJFoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 00:44:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=QCXPNwhmIzalJMiH3X5AT6LwZUi/TV95N5fKKgoF1067SCBc8tDpcHhB3PKQtiv7QU61+Kk0xFquKWsQECVi6lnrCjmGTEf5z9hi97NUXmB2LzGG6pmGtFHRHkccrVPeOUHLwIqusGd95Nppl5z1aWLvdwkeEtiUM1y7DDdzRJ8=;
X-YMail-OSG: Oeot_NQVM1md4fx1sn_ekXEwL1epeVVSKf6i2G4kOqTJ2Gg17i_aoCh0KG.aZSMLRKiAtZMeLJIgvzSWpaBF91W55TpDEvwG1vWKbOwY7_V9QrrgR_95odpohrBc27G15kuUGa9ADkfDcQWnKAxelhB8z21VctXmR6gBxb9hYD8fG9TAyJoym2bKkoip
Date: Thu, 9 Nov 2006 21:44:13 -0800 (PST)
From: Jonathan Day <imipak@yahoo.com>
Subject: Zero-copy question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <232602.80524.qm@web31502.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on a problem involving zero-copy between
an external device and physical memory, where the
total length of data is not known in advance, where
allowance must be made for non-contiguous pages in
physical memory and where any number of simultaneous
channels can be going in parallel.

Whilst I am waiting for suitable medication to arrive,
I've been trying to figure out a way in which this
problem can be solved.

My first question would be: has anyone already solved
this, thus saving my sanity? When I've looked up
zero-copy, the main reference I've found is for moving
data from fixed storage to a network. This is useful,
but doesn't quite solve the problem at hand, as you
never need more than a page at a time, so don't have
memory fragmentation to contend with.

My second question is then: assuming that zero-copy in
these situations has been deemed a Bad Idea for
whatever reason, what is the fastest method of doing
bi-directional transfers? (Feel free to assume some
logic on the device.)

Finally, I'd be interested in hearing the opinions of
Linux kernel developers on using structured memory
groups in the kernel for parallel I/O of this kind,
abandoning the zero-copy approach. Although I know a
fair number of kernel projects, I don't know of one
that uses SMGs - am I missing some obvious ones or is
there a known reason for avoiding the SMG approach?

Jonathan Day



 
____________________________________________________________________________________
Want to start your own business?
Learn how on Yahoo! Small Business.
http://smallbusiness.yahoo.com/r-index
