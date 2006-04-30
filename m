Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWD3JPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWD3JPE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 05:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWD3JPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 05:15:04 -0400
Received: from zakalwe.fi ([80.83.5.154]:45064 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S1751071AbWD3JPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 05:15:03 -0400
Date: Sun, 30 Apr 2006 09:15:01 +0000
From: Heikki Orsila <shd@zakalwe.fi>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Mark Rosenstand <mark@borkware.net>, linux-kernel@vger.kernel.org
Subject: Re: World writable tarballs
Message-ID: <20060430091501.GA19566@zakalwe.fi>
References: <1146356286.10953.7.camel@hammer> <200604300148.12462.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200604300148.12462.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2006 at 01:48:12AM +0100, Alistair John Strachan wrote:
> There's no need to repeatedly discuss it.

I think there is. Sorry for wasting bandwidth.

It's a big security hole deliberately caused by the kernel people (files
in the tar ball have og+w, so it's not problem in roots umask or tar).
Real security needs _simplicity_ but current file modes require
unnecessary _tricks_ for admins. There should be nothing against
untarring files as root. In this case it makes sense too, because only
the tar balls are crypto signed, not the individual files inside the tar
ball, so root can conveniently just verify the crypto signature and
untar the file without any race conditions or trusting other users. The
only real alternative is to create an _unnecessary_ trusted user to do
tar ball handling.

PS. this file permission bug almost bit me. People make errors and this
one is potentially a big privilege escalation, because it potentially
turns normal application bugs into root privileges.

-- 
Heikki Orsila                   Barbie's law:
heikki.orsila@iki.fi            "Math is hard, let's go shopping!"
http://www.iki.fi/shd
