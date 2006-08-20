Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbWHTWkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWHTWkf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWHTWkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:40:35 -0400
Received: from mother.openwall.net ([195.42.179.200]:47567 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751733AbWHTWke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:40:34 -0400
Date: Mon, 21 Aug 2006 02:34:42 +0400
From: Solar Designer <solar@openwall.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop.c: kernel_thread() retval check
Message-ID: <20060820223442.GA21960@openwall.com>
References: <20060819234629.GA16814@openwall.com> <1156097717.4051.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156097717.4051.26.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

On Sun, Aug 20, 2006 at 07:15:17PM +0100, Alan Cox wrote:
> Acked-by: Alan Cox <alan@redhat.com>

Thanks.

> but should go into 2.6-mm and be tested in 2.6-mm before 2.4 backport.

Unfortunately, I do not intend to prepare/test/submit a revision of the
patch for 2.6-mm, and I might only work on a 2.6 patch in a few months
from now.  Unless someone else takes care of this, the fix is likely to
get dropped on the floor.

Do you really think that getting this fix into 2.4 should be delayed
like that?  Please note that the patch affects error path only and that
without the patch things misbehave badly whenever the error occurs.
I really don't think the patch can make things worse, even if it were
buggy (although it's been tested with the error path triggered
specifically on 2.4).

Alexander
