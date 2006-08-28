Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWH1VLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWH1VLg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWH1VLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:11:36 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:8173 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932094AbWH1VLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:11:35 -0400
Subject: Re: [PATCH 2.6.18-rc4-mm2] fs/jfs: Conversion to generic boolean
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
In-Reply-To: <44F35537.6000308@student.ltu.se>
References: <44F086E8.7090602@student.ltu.se>
	 <1156774979.7495.5.camel@kleikamp.austin.ibm.com>
	 <44F35537.6000308@student.ltu.se>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 16:11:32 -0500
Message-Id: <1156799492.8732.19.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 22:42 +0200, Richard Knutsson wrote:

> Just why is it, that when there is a change to make locally defined 
> booleans into a more generic one, it is converted into integers? ;)

I just see this as an opportunity to make jfs more closely fit the
coding style of the mainline kernel.

> But seriously, what is gained by removing them, other then less 
> understandable code? (Not talking about FALSE -> 0, but boolean_t -> int)

I don't feel strongly one way or another about the use of boolean_t, but
under fs/, the only code that uses that type is in fs/jfs and fs/xfs,
which are both ported from other operating systems.  Using ints for
boolean values does seem to be the accepted practice in the kernel.

> I can understand if authors disprove making an integer into a boolean, 
> but here it already were booleans.
> But hey, you are the maintainer ;)

I could be persuaded to leave the declarations as boolean_t or even
making them bool, but right now I'm leaning toward making them int for
consistency.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

