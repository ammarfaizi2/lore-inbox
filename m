Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272246AbTHKFbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272263AbTHKFbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:31:31 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:60175 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S272246AbTHKFba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:31:30 -0400
Date: Mon, 11 Aug 2003 07:30:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Chip Salzenberg <chip@pobox.com>
Cc: Jamie Lokier <jamie@shareable.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030811053059.GB28640@alpha.home.local>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local> <20030811012337.GI24349@perlsupport.com> <20030811020957.GE10446@mail.jlokier.co.uk> <20030811023912.GJ24349@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811023912.GJ24349@perlsupport.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 10:39:12PM -0400, Chip Salzenberg wrote:
 
> Both parameters of __builtin_expect() are long ints.  On an
> architecture where there's a pointer type larger than long[1],
> __builtin_expect() won't just warn, it'll *fail*.  Also, on an
> architecture where a conversion of a null pointer to long results in
> a non-zero value[2], it'll *fail*.  That makes it non-portable twice
> over.  Wouldn't you agree?

Hmmm Chip, on the document you suggested us to read, I remember a statement
about (!x) <=> (x == 0) which implied it's legal even if x is a pointer because
the compiler will automatically do the comparison between x and NULL and not
(int)x and 0. Perhaps I have dreamed, but I'm sure I read this. So in any case,
the !!(x) construct should be valid.

Cheers,
Willy

