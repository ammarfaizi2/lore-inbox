Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVBPW3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVBPW3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 17:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVBPW3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 17:29:30 -0500
Received: from pop.gmx.net ([213.165.64.20]:52140 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262038AbVBPW31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 17:29:27 -0500
X-Authenticated: #8956447
Subject: Re: [Problem] slow write to dvd-ram since 2.6.7-bk8
From: Droebbel <droebbel.melta@gmx.de>
To: Tino Keitel <tino.keitel@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1108590900.7407.11.camel@localhost.localdomain>
References: <1108301794.9280.18.camel@localhost.localdomain>
	 <20050213142635.GA2035@animx.eu.org>
	 <20050214085320.GA4910@dose.home.local>
	 <1108376734.9495.8.camel@localhost.localdomain>
	 <20050214105332.GA7163@dose.home.local>
	 <1108379351.9495.22.camel@localhost.localdomain>
	 <20050214111819.GA7691@dose.home.local>
	 <1108590900.7407.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 23:29:24 +0100
Message-Id: <1108592965.7407.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2005-02-16 at 22:55 +0100, Droebbel wrote:
>Some new information:
>
>2.6.7 is ok, 2.6.7-mm2 is not ok, 2.6.7 with just the linus-patch from
>mm2 is ok, 2.6.7 with linus.patch from mm3 isn't.
>So I took some of the patches from the broken-out mm2 and tested them
>seperately.
>
>The vmscan-dont-reclaim-too-many-pages.patch led to the said reduction
>of writing speed. I reverse-applied it to 2.6.8.1, where it seems to
>solve the problem.

Sorry, have to correct that: it seemed to help at my tests with dd
(write 1G of zeroes to a file). Copying a file with mc still shows
around 1.4MB/s. Could be worse, but is definitely not ok. It *is* better
with 2.6.7.

Regards

David

