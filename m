Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272311AbTHIJgu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 05:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272316AbTHIJgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 05:36:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:27524 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272311AbTHIJgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 05:36:49 -0400
Date: Sat, 9 Aug 2003 10:36:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Willy Tarreau <willy@w.ods.org>, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org, chip@pobox.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030809093629.GB28566@mail.jlokier.co.uk>
References: <1060087479.796.50.camel@cube> <20030809002117.GB26375@mail.jlokier.co.uk> <20030809081346.GC29616@alpha.home.local> <20030809015142.56190015.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809015142.56190015.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Sat, 9 Aug 2003 10:13:46 +0200 Willy Tarreau <willy@w.ods.org> wrote:
> 
> > (how could !!x be 0 if x isn't ?)
> 
> I believe the C language allows for systems where the NULL pointer is
> not zero.

That is irrelevant.  The GCC manual says you can't use a pointer as
the argument to __builtin_expect anyway:

     Since you are limited to integral expressions for EXP, you should
     use constructions such as

          if (__builtin_expect (ptr != NULL, 1))
            error ();

     when testing pointer or floating-point values

-- Jamie
