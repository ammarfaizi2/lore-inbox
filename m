Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263416AbTDSQtC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 12:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbTDSQtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 12:49:02 -0400
Received: from mail.ithnet.com ([217.64.64.8]:23312 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263416AbTDSQtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 12:49:00 -0400
Date: Sat, 19 Apr 2003 19:00:46 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030419190046.6566ed18.skraw@ithnet.com>
In-Reply-To: <1050766175.3694.4.camel@dhcp22.swansea.linux.org.uk>
References: <20030419180421.0f59e75b.skraw@ithnet.com>
	<1050766175.3694.4.camel@dhcp22.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Apr 2003 16:29:36 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sad, 2003-04-19 at 17:04, Stephan von Krawczynski wrote:
> > after shooting down one of this bloody cute new very-big-and-poor IDE
> > drives today I wonder whether it would be a good idea to give the linux-fs
> > (namely my preferred reiser and ext2 :-) some fault-tolerance. I remember
> > there have been some discussions along this issue some time ago and I guess
> > remembering that it was decided against because it should be the drivers
> > issue to give the fs a clean space to live, right?
>  
> Sometimes disks just go bang. They seem to do it distressingly more
> often nowdays which (while handy for criminals and pirates) is annoying
> for the rest of us. Putting magic in the file system to handle this is
> hard to do well, and at best you get things like ext2/ext3 have now -
> the ability to recover data in the event of some corruption, unless you
> get into really fancy stff.

Ok, you mean active error-recovery on reading. My basic point is the writing
case. A simple handling of write-errors from the drivers level and a retry to
write on a different location could help a lot I guess.

> Buy IDE disks in pairs use md1, and remember to continually send the
> hosed ones back to the vendor/shop (and if they keep appearing DOA to
> your local trading standards/fair trading type bodies).

Just to give some numbers: from 25 disk I bought during last half year 16 have
gone dead within the first month. This is ridiculous. Of course they are all
returned and guarantee-replaced, but it gets on ones nerves to continously
replace disks, the rate could be lowered if one could use them at least 4
months (or upto a deadline number of bad blocks mapped by the fs - still
guarantee but fewer replacement cycles).

> Perhaps someone should also start a scoreboard for people to report dead
> IDE drives by vendor ;)

I sure have contribution to it.

> Alan

Regards,
Stephan

