Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273937AbRIXPcI>; Mon, 24 Sep 2001 11:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273938AbRIXPb4>; Mon, 24 Sep 2001 11:31:56 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:44036 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S273937AbRIXPbr>; Mon, 24 Sep 2001 11:31:47 -0400
Date: Mon, 24 Sep 2001 17:32:10 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010924173210.A7630@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <B0005839269@gollum.logi.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <B0005839269@gollum.logi.net.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Beau Kuiper wrote:

> Also, the performace problems seem to be very dependant on the hardware being 
> used. 5400rpm drives get hurt a lot, while 7200 rpm drives seem to handle it 
> better. Decent write caching on IDE devices (like the 2meg buffer on the IBM) 
> can completely hide this issue.

Decent write caching on IDE devices can eat your whole file system.

Turn it off (I have no idea of internals, but I presume it'll still be a
write-through cache, so reading back will still be served from the
buffer). Do hdparm -W0 /dev/hd[a-h].

One might consider adding TCQ to the IDE driver. FreeBSD already has it,
and IBM drives talk it.
