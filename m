Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbREIVJG>; Wed, 9 May 2001 17:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbREIVI4>; Wed, 9 May 2001 17:08:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10379 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132482AbREIVIs>;
	Wed, 9 May 2001 17:08:48 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15097.45528.322497.299933@pizda.ninka.net>
Date: Wed, 9 May 2001 14:08:40 -0700 (PDT)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105091537170.14138-100000@freak.distro.conectiva>
In-Reply-To: <15097.41719.48461.215024@pizda.ninka.net>
	<Pine.LNX.4.21.0105091537170.14138-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti writes:
 > > Let me state it a different way, how is the new writepage() framework
 > > going to do things like ignore the referenced bit during page_launder
 > > for dead swap pages?
 > 
 > Its not able to ignore the referenced bit. 
 > 
 > I know we want that, but I can't see any clean way of doing that. 

Unfortunately, one way would involve pushing the referenced bit check
into the writepage() method.  But that is the only place we have the
kind of information necessary to make these decisions.

This is exactly the kind of issue Linus and myself were talking
about when the "cost analysis" parts of thie discussion began.

Later,
David S. Miller
davem@redhat.com
