Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbTAFSG7>; Mon, 6 Jan 2003 13:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267082AbTAFSG7>; Mon, 6 Jan 2003 13:06:59 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:27776 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S267081AbTAFSG6>;
	Mon, 6 Jan 2003 13:06:58 -0500
To: Stephen Evanchik <evanchsa@clarkson.edu>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.54] hermes: serialization fixes
References: <200301031239.29226.evanchsa@clarkson.edu>
	<20030103124754.A16519@redhat.com>
	<200301031256.41451.evanchsa@clarkson.edu>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 06 Jan 2003 18:40:17 +0100
In-Reply-To: <200301031256.41451.evanchsa@clarkson.edu>
Message-ID: <878yxyqiri.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Evanchik <evanchsa@clarkson.edu> writes:

> On Friday 03 January 2003 12:47, you wrote:
> |  Why not put the spinlock/unlock inside hermes_bap_seek()?  Smaller, better
> |  contained and more readable.
> 
> That's the better solution, I'm trying to coordinate a bit with the 
> maintainer. The only reason I didn't do this in the first place is because 
> there is a (possibly unecessary) delay loop inside hermes_bap_seek that I 
> believe is trying to combat the same problem. I'm awaiting a response from 
> the maintainer since he knows a bit more about the hardware than I do.
> 

There is something not quite right about this patch. I used have a ton
of errors in my logs, and this patch seemed to clear this out nicely.

When I run with a patched driver now, I run for about 20 minutes with
various loads and sudenly the ksoftirqd_CPU0 process starts to hog my
CPU and not wanting to let go. As soon as I pull out the card, the
load returns to normal.

Is there any way I can provide more details on what is happening?

> 
> Stephen
> 

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
