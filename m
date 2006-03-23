Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWCWKGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWCWKGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 05:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWCWKGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 05:06:20 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:57023 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1751018AbWCWKGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 05:06:19 -0500
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] add private data to notifier_block
References: <Pine.LNX.4.44L0.0603221402070.7453-100000@iolanthe.rowland.org>
	<1143061212.8924.10.camel@whizzy>
From: Jes Sorensen <jes@sgi.com>
Date: 23 Mar 2006 05:06:17 -0500
In-Reply-To: <1143061212.8924.10.camel@whizzy>
Message-ID: <yq0u09ptqzq.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kristen" == Kristen Accardi <kristen.c.accardi@intel.com> writes:

Kristen> On Wed, 2006-03-22 at 14:04 -0500, Alan Stern wrote:
>> I still think this isn't really needed.  The same effect can be
>> accomplished by embedding a notifier_block struct within a larger
>> structure that also contains the data pointer.

Kristen> I thought of this, but felt it would make for less easy to
Kristen> read code.  But, that's just my personal style.

I'd have to vote for Alan's side here. Thats why we have the
containerof() stuff. It also means you can embed more than just a
pointer with the notifier block and it will generate more efficient
code when doing so.

Cheers,
Jes
