Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbUJWSWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUJWSWx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 14:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUJWSWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 14:22:53 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:22050 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261267AbUJWSWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 14:22:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LvS0H2ZFwK0pPikVX0pmToNGEHfl6E0rzkifvS6S5m6Vc5FhmcQDErRR5i8c4hFh/T50GRJXw6O53jkzEOuFgQ28yHrBnxI8lZ8JdOfhe98MwKNEkjkUspFPiQXi9s7Qao5j4Ei/fZQne7SNu4rQ51SMUgoaIGhMUhPDrBO9FXU=
Message-ID: <9e47339104102311229276d8@mail.gmail.com>
Date: Sat, 23 Oct 2004 14:22:51 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
In-Reply-To: <20041023095644.GC30137@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e473391041022214570eab48a@mail.gmail.com>
	 <20041023095644.GC30137@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 10:56:44 +0100, Christoph Hellwig <hch@infradead.org> wrote:
> Sorry, wrong API.  At least export the individual functions and use them
> directly (and without the symbol_get abnomination that's not any better
> than inter_module_*).

I put a new version in DRM CVS that uses the symbols directly. It
checks out with AGP compiled in and not in.

You might want to give DRM CVS another look. We are getting ready to
submit the code in the linux-core/shared-core directories to the
kernel.

There are still coding style issues. These are slowly getting fixed
but on the other hand we don't want to break the working code. We can
fix a few more on each round of submissions. Main highlights of this
version are elimination of the DRM() macros and elminination of
inter_module() use for both DRM and AGP.


-- 
Jon Smirl
jonsmirl@gmail.com
