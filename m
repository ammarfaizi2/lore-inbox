Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbSJHTsS>; Tue, 8 Oct 2002 15:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbSJHTrM>; Tue, 8 Oct 2002 15:47:12 -0400
Received: from tapu.f00f.org ([66.60.186.129]:53736 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S261505AbSJHTqm>;
	Tue, 8 Oct 2002 15:46:42 -0400
Date: Tue, 8 Oct 2002 12:52:23 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021008195223.GA5040@tapu.f00f.org>
References: <1034044736.29463.318.camel@phantasy> <20021008183824.GA4494@tapu.f00f.org> <1034102950.30670.1433.camel@phantasy> <20021008190513.GA4728@tapu.f00f.org> <1034104637.29468.1483.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034104637.29468.1483.camel@phantasy>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 03:17:16PM -0400, Robert Love wrote:

> Yep.  Linux treats most "hints" (e.g. madvise) as a requirement - it
> fails if it cannot do it.  That is against the spec most of the
> time, but oh well...

There is no spec for O_DIRECT... SGI 'invented' this in '93 or perhaps
earlier (but the idea wasn't new) for IRIX.

O_DIRECT is a very special thing, you shouldn't ask for this unless
yoy know you want it and how to deal with it --- treating it as
anything less that a requirement is bogus IMO.

> Shrug.  I do not have much experience with O_DIRECT.  I suspect the
> synchronous nature and the requirement of aligned buffers is not
> ideal.

I'm not sure how being synchornous matters if you use a different
thread (perhaps it's a pain), this also allows your own user-space
code to implement read-ahead?  Buffer alignment issues in practice
really aren't that bad.

If someone can think of a meaningful benchmark that would be cool; if
not, then I'll hack up the code I wrote to stream DVD vobs about and
see how that compares.



  --cw
