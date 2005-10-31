Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVJaLdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVJaLdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVJaLdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:33:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15289 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751082AbVJaLdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:33:40 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17254.252.746357.935671@segfault.boston.redhat.com>
Date: Mon, 31 Oct 2005 06:33:16 -0500
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
In-Reply-To: <Pine.LNX.4.63.0510291536320.2949@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
	<17203.7543.949262.883138@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
	<17205.48192.180623.885538@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
	<17208.24786.729632.221157@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510152006340.30122@donald.themaw.net>
	<17238.45372.628520.739194@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510291536320.2949@donald.themaw.net>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:

raven> So to resolve this we need to ignore negative and unhashed dentries
raven> when checking if directory dentry is empty.
>>
raven> Please test this patch and let me know how you go.
>> OK, I've finally got 'round to testing your patch.  It does fix the test
>> case I was using.  My only concern is the potential for regressions.
>> I'll try making sure all of my various maps still work as advertised.

raven> I've spotted a regression with this patch.  It doesn't stop autofs
raven> from appearing to function correctly. It causes mount callbacks when
raven> they shouldn't made. So it seems that there is a case when an autofs
raven> directory is, as yet unhashed, but should be used.

I'm not sure I follow.  What do you mean it doesn't stop autofs from
*appearing* to function correctly?  Do you have a reproducer that fails?

-Jeff
