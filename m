Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUEXSnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUEXSnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 14:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUEXSnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 14:43:51 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:31406 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S263943AbUEXSnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 14:43:50 -0400
Date: Mon, 24 May 2004 19:28:13 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Paul Rolland <rol@as2917.net>
Cc: "'Phy Prabab'" <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <20040524172813.GB4434@k3.hellgate.ch>
Mail-Followup-To: Paul Rolland <rol@as2917.net>,
	'Phy Prabab' <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
References: <20040524005751.62303.qmail@web90006.mail.scd.yahoo.com> <200405240633.i4O6Xu621252@tag.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405240633.i4O6Xu621252@tag.witbe.net>
X-Operating-System: Linux 2.4.25 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004 08:33:49 +0200, Paul Rolland wrote:
> Hello, 
> 
> > 2.6.7-p1:
> > 24.86user 51.77system 2:58.87elapsed 42%CPU
> > (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (13major+7591686minor)pagefaults
> > 0swaps
> > 
> > 2.4.21:
> > 28.68user 34.98system 1:12.34elapsed 87%CPU
> > (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (5691267major+1130523minor)pagefaults
> > 0swaps
> > 
> > 
> > Both runs on the same machine with the same process
> > (making headers).
> > 
> > Could someone give me some pointers/directions on
> > where to look.
> 
> Any reason why there is such a difference in the pagefaults
> numbers between 2.4.x and 2.6.x ????
> Could it explain a part of the time differences ?

Probably no. Last time I checked, the major fault field for rusage
contained bogus data (included minor faults as well). Looks like that
got fixed in 2.6.

Roger
