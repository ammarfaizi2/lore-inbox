Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263210AbREMRxr>; Sun, 13 May 2001 13:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbREMRxh>; Sun, 13 May 2001 13:53:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43180 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263210AbREMRxB>;
	Sun, 13 May 2001 13:53:01 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15102.51701.679466.475230@pizda.ninka.net>
Date: Sun, 13 May 2001 10:52:53 -0700 (PDT)
To: Rik van Riel <riel@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105131332050.5468-100000@imladris.rielhome.conectiva>
In-Reply-To: <15096.42935.213398.64003@pizda.ninka.net>
	<Pine.LNX.4.21.0105131332050.5468-100000@imladris.rielhome.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel writes:
 > On Tue, 8 May 2001, David S. Miller wrote:
 > > Nice.  Now the only bit left is moving the referenced bit
 > > checking and/or state into writepage as well.  This is still
 > > part of the plan right?
 > 
 > Why the hell would we want this ?

Because if it's a dead swap page the referenced bit is meaningless
and we should just kill off the page immediately.

Later,
David S. Miller
davem@redhat.com
