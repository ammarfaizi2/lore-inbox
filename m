Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbREIUFm>; Wed, 9 May 2001 16:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbREIUFc>; Wed, 9 May 2001 16:05:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41354 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130768AbREIUFV>;
	Wed, 9 May 2001 16:05:21 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15097.41719.48461.215024@pizda.ninka.net>
Date: Wed, 9 May 2001 13:05:11 -0700 (PDT)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105091437130.13878-100000@freak.distro.conectiva>
In-Reply-To: <15096.42935.213398.64003@pizda.ninka.net>
	<Pine.LNX.4.21.0105091437130.13878-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti writes:
 > You want writepage() to check/clean the referenced bit and move the page
 > to the active list itself ?

Well, that's the other part of what my patch was doing.

Let me state it a different way, how is the new writepage() framework
going to do things like ignore the referenced bit during page_launder
for dead swap pages?

Later,
David S. Miller
davem@redhat.com
