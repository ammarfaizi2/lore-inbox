Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbUD3AZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUD3AZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 20:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265034AbUD3AZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 20:25:00 -0400
Received: from holomorphy.com ([207.189.100.168]:19584 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263000AbUD3AY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 20:24:59 -0400
Date: Thu, 29 Apr 2004 17:24:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com
Subject: Re: 2.6.6-rc2-mm2
Message-ID: <20040430002455.GA996@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	James.Bottomley@steeleye.com
References: <20040426013944.49a105a8.akpm@osdl.org> <20040429184126.GB783@holomorphy.com> <20040429134546.5e9515d8.akpm@osdl.org> <20040429211825.GC783@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429211825.GC783@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 01:45:46PM -0700, Andrew Morton wrote:
>> bk-scsi.patch will be the one to try.

On Thu, Apr 29, 2004 at 02:18:25PM -0700, William Lee Irwin III wrote:
> Is there a split-up version of that anywhere I can do bisection search on?

I finished bisecting. It was this:

$ head -80 patches/bk-scsi.patch | tail -5 | egrep -v '^#[      ]+$'
# ChangeSet
#   2004/04/25 09:10:30-05:00 akpm@osdl.org 
#   [PATCH] aic7xxx: fix oops whe hardware is not present
#   From: Herbert Xu <herbert@gondor.apana.org.au>


-- wli
