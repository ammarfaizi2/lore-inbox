Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263214AbREMSAr>; Sun, 13 May 2001 14:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbREMSAl>; Sun, 13 May 2001 14:00:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48556 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263214AbREMSAZ>;
	Sun, 13 May 2001 14:00:25 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15102.52141.725459.804694@pizda.ninka.net>
Date: Sun, 13 May 2001 11:00:13 -0700 (PDT)
To: Rik van Riel <riel@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105131455090.5468-100000@imladris.rielhome.conectiva>
In-Reply-To: <15102.51701.679466.475230@pizda.ninka.net>
	<Pine.LNX.4.21.0105131455090.5468-100000@imladris.rielhome.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel writes:
 > Then I'd rather check this in a visible place in page_launder()
 > itself. Granted, this is a special case, but I don't think this
 > one is worth obfuscating the code for...

I think Linus's scheme is just fine, controlling the new 'priority'
argument to writepage() using the referenced bit as an input.

Later,
David S. Miller
davem@redhat.com
