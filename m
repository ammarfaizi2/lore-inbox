Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTE2R00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTE2R00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:26:26 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:6548 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262451AbTE2R0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:26:25 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Hugh Dickins <hugh@veritas.com>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [RFC][PATCH] Avoid vmtruncate/mmap-page-fault race
Date: Thu, 29 May 2003 19:39:47 +0200
User-Agent: KMail/1.5.1
Cc: <akpm@digeo.com>, <hch@infradead.org>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305291723310.1800-100000@localhost.localdomain> <200305291915.22235.phillips@arcor.de>
In-Reply-To: <200305291915.22235.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305291939.47451.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 May 2003 19:15, Daniel Phillips wrote:
> On Thursday 29 May 2003 18:33, you wrote:
> > Me?  I much preferred your original, much sparer, nopagedone patch
> > (labelled "uglyh as hell" by hch).
>
> "me too".

Oh wait, I mispoke... there is another formulation of the patch that hasn't 
yet been posted for review.  Instead of having the nopagedone hook, it turns 
the entire do_no_page into a hook, per hch's suggestion, but leaves in the 
->nopage hook, which makes the patch small and obviously right.  I need to 
post that version for comparison, please bear with me.

IMHO, it's nicer than the ->nopagedone form.

Regards,

Daniel
