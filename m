Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTGCLsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTGCLsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:48:18 -0400
Received: from 69-55-72-144.ppp.netsville.net ([69.55.72.144]:678 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S265152AbTGCLsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:48:17 -0400
Subject: Re: Status of the IO scheduler fixes for 2.4
From: Chris Mason <mason@suse.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, andrea@suse.de, piggin@cyberone.com.au
In-Reply-To: <20030703125828.1347879d.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva>
	 <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva>
	 <1057197726.20903.1011.camel@tiny.suse.com>
	 <20030703125828.1347879d.skraw@ithnet.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057233714.20899.1014.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Jul 2003 08:01:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-03 at 06:58, Stephan von Krawczynski wrote:
> On 02 Jul 2003 22:02:07 -0400
> Chris Mason <mason@suse.com> wrote:
> 
> > [...]
> > Nick would like to see a better balance of throughput/fairness, I wimped
> > out and went for the userspace toggle instead because I think anything
> > else requires pulling in larger changes from 2.5 land.
> 
> I have a short question on that: did you check if there are any drawbacks on
> network performance through this? We had a phenomenon here with 2.4.21 with
> both samba and simple ftp where network performance dropped to a crawl when
> simply entering "sync" on the console. Even simple telnet-sessions seemed to be
> affected. As we could not create a reproducable setup I did not talk about this
> up to now, but I wonder if anyone else ever checked that out ...

It's possible the network programs involved are actually getting stuck
in atime updates somewhere.  A decoded sysrq-t during one of the stalls
would help find the real cause.

-chris

