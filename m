Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWIAFqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWIAFqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 01:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWIAFqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 01:46:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932316AbWIAFqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 01:46:49 -0400
Date: Thu, 31 Aug 2006 22:46:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] fs/bio.c: tweaks
Message-Id: <20060831224643.da0c1fe7.akpm@osdl.org>
In-Reply-To: <20060831212023.GA13918@rhlx01.fht-esslingen.de>
References: <20060831212023.GA13918@rhlx01.fht-esslingen.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 23:20:23 +0200
Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:

> Calculate a variable in bvec_alloc_bs() only once needed, not earlier
> (bio.o down from 18408 to 18376 Bytes, 32 Bytes saved, probably due to
> data locality improvements).

OK, I spose.

> Init variable idx to silence a gcc warning which already existed in the
> unmodified original base file (bvec_alloc_bs() handles idx
> correctly, so there's no need for the warning):
> fs/bio.c: In function `bio_alloc_bioset':
> fs/bio.c:169: warning: `idx' may be used uninitialized in this function

I'm heartily sick of that one too.

> Inline bio_set_map_data() since it's only called once.

Is OK, gcc will take care of that.


