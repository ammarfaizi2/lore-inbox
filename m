Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269066AbUI2Vx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269066AbUI2Vx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269070AbUI2Vx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:53:59 -0400
Received: from [69.25.196.29] ([69.25.196.29]:4833 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S269066AbUI2Vx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:53:58 -0400
Date: Wed, 29 Sep 2004 17:53:15 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz
Subject: Re: [PROPOSAL/PATCH 2] Fortuna PRNG in /dev/random
Message-ID: <20040929215315.GB6769@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>, linux@horizon.com,
	linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz
References: <20040924005938.19732.qmail@science.horizon.com> <20040929171027.GJ16057@certainkey.com> <20040929193117.GB6862@thunk.org> <20040929202707.GO16057@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929202707.GO16057@certainkey.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 04:27:07PM -0400, Jean-Luc Cooke wrote:
> 
> Here's patch v2.1.2 that waits at least 0.1 sec before reseeding for
> non-blocking reads to alleviate Ted's concern wrt waiting for reseeds.

You didn't include the patch, and in any case, you'll probably want to
probably want to do it for both blocking as well as non-blocking
reads.  And keep in mind, it's not *my* concerns, but it's Neil
Ferguson and Bruce Schneier's concerns.  After all, if you're going to
call it Fortuna, you might as well be faithful to their design,
especially since if you don't, you're leaving it to be utterly
vulnerable to this state extension attack they are so worried about.

						- Ted
