Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTLVXca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbTLVXca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:32:30 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:6272
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S264601AbTLVXc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:32:28 -0500
Date: Mon, 22 Dec 2003 18:32:25 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop.c patches, take two
Message-ID: <20031222233223.GA4700@fukurou.paranoiacs.org>
Mail-Followup-To: Ben Slusky <sluskyb@fukurou.paranoiacs.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221195534.GA4721@fukurou.paranoiacs.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22 2003 01:36:29 -0500, Andrew Morton <akpm@osdl.org> wrote:
> I'm not sure how important this is?
> 
> Remember that one of the reasons for dropping the block-backed special case
> was that it ran like crap under heavy load. It locked up, iirc. Has that
> been fixed here?

Yes, the old block-backed code was prone to deadlock when trying to
allocate memory under heavy I/O. This patch fixes it.

As to how important this is, it fixes this bug and makes loop devices
usable for swap, i.e. enables encrypted swap. Everybody likes bugfixes
and encrypted swap, right?

-
-Ben


-- 
Ben Slusky                      | The human race never solves
sluskyb@paranoiacs.org          | any of its problems. It merely
sluskyb@stwing.org              | outlives them.
PGP keyID ADA44B3B              |               -David Gerrold
