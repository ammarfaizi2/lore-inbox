Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135716AbRAYSTV>; Thu, 25 Jan 2001 13:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135662AbRAYSTF>; Thu, 25 Jan 2001 13:19:05 -0500
Received: from zeus.kernel.org ([209.10.41.242]:50648 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135747AbRAYSSn>;
	Thu, 25 Jan 2001 13:18:43 -0500
Date: Thu, 25 Jan 2001 18:16:21 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: David Wragg <dpw@doc.ic.ac.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: limit on number of kmapped pages
Message-ID: <20010125181621.W11607@redhat.com>
In-Reply-To: <y7rsnmav0cv.fsf@sytry.doc.ic.ac.uk> <m1r91udt59.fsf@frodo.biederman.org> <y7rofwxeqin.fsf@sytry.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <y7rofwxeqin.fsf@sytry.doc.ic.ac.uk>; from dpw@doc.ic.ac.uk on Wed, Jan 24, 2001 at 12:35:12AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 24, 2001 at 12:35:12AM +0000, David Wragg wrote:
> 
> > And why do the pages need to be kmapped? 
> 
> They only need to be kmapped while data is being copied into them.

But you only need to kmap one page at a time during the copy.  There
is absolutely no need to copy the whole chunk at once.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
