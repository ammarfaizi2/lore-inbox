Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTIPPVA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTIPPVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:21:00 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:42126 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261930AbTIPPU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:20:59 -0400
X-Sender-Authentication: net64
Date: Tue, 16 Sep 2003 17:20:57 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: marcelo.tosatti@cyclades.com.br, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030916172057.148a5741.skraw@ithnet.com>
In-Reply-To: <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk>
References: <20030916102113.0f00d7e9.skraw@ithnet.com>
	<Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet>
	<20030916153658.3081af6c.skraw@ithnet.com>
	<1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 15:36:14 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2003-09-16 at 14:36, Stephan von Krawczynski wrote:
> > Well, I do understand the bounce buffer problem, but honestly the current
> > way of handling the situation seems questionable at least. If you ever
> > tried such a system you notice it is a lot worse than just dumping the
> > additional ram above 4GB. You can really watch your network connections go
> > bogus which is just unacceptable. Is there any thinkable way to ommit the
> > bounce buffers and still do something useful with the beyond-4GB ram parts?
> 
> The 2.6 tree is somewhat better about this but at the end of the day if
> your I/O subsystem can't do the job your box will not perform ideally.

Hm, "not ideally" is a real friendly word for describing the mess ;-)
Isn't there a possibility to flag this part of the memory as nonDMA-able, kind
of "do whatever you want with it, but don't expect any dma-driven i/o"...
I know this gets a problem when swap jumps in, though.
But really it is far better for the box to flag it more or less unusable
compared to a DoS done by user-space "find" ...
I know this is a real corner case of life. It looks more like taking a
different decision than current to improve the situation and not so much a real
development topic. Probably a note in kernel docs reading "DON'T DO THIS" is
either sufficient...


Regards,
Stephan

