Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbSKMXzZ>; Wed, 13 Nov 2002 18:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbSKMXzZ>; Wed, 13 Nov 2002 18:55:25 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:37393 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264665AbSKMXzY>; Wed, 13 Nov 2002 18:55:24 -0500
Date: Thu, 14 Nov 2002 00:02:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: torvalds@transmeta.com, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: module mess in -CURRENT
Message-ID: <20021114000206.A8245@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	torvalds@transmeta.com, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Rusty,

what the hell is going on with the modules code in 2.5-CURRENT?

Rusty's monsterpatch breaks basically everything (and remember we're
in feature freeze!) instead of doing one thing at a time [1], and it
is doing three things that are absolutely separate issues.

We had an almost useable 2.5 and now exactly when we're feature freezing
and people are expected to test it we break everything?

Linus, please backout that patch until we a) have modutils that support
both the new and old code and b) support at least such basic features
as parsing modules.conf and supporting parameters.

Rusty, the next time please submit stuff one feature at a time instead
of a monster patch that is cool but breaks everything but looks cool.

The inkernel loader, generic boot-time option and your - umm - strange
idea of module unload race reduction are absolute separate things.

[1] e.g. kbuild2.5 was rejected due to the must change everything criteria.
not that I actually liked the kbuild2.5 design, but this is exactly the
same thing.
