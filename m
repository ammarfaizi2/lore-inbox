Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292581AbSBTXa5>; Wed, 20 Feb 2002 18:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292582AbSBTXar>; Wed, 20 Feb 2002 18:30:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61966 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292581AbSBTXah>; Wed, 20 Feb 2002 18:30:37 -0500
Subject: Re: socket API extensions workgroup at OpenGroup needs HELP
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Wed, 20 Feb 2002 23:44:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, ssharma@us.ibm.com
In-Reply-To: <200202202257.g1KMv4c04306@devserv.devel.redhat.com> from "Pete Zaitcev" at Feb 20, 2002 05:57:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dgPr-000595-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would not mind to participate in something more open.
> If anyone has a suggestion of a mailing list which works
> in a way of tcp-implementors, but on the topic of socket API
> extensions for Infiniband, then I am interested.

You need to understand that most of the wacko DMA schemes have already been
laughed out of the IETF - things like TCP RDMA have all turned into 
"this way happens to suit my hardware" "we'll we've got a patent on that
way" and other debacles, followed by other people pointing out that they
already get that performance without hacking up protocols and API's.

The existing socket API supports zero copy. SGI proved this a long time back
(Im sure Larry McVoy can give dates). The existing unix aio and real time
signal model supports all the notification needed for efficient scalable
I/O.

You can also implement the entire socket layer in user space on top of
hardware that already does all the brainwork (also been done). 

In fact I have a submission for what is needed in API changes. Its a blank
piece of paper right now. 

I do agree and I ask the proposed chairs to comment on this - that the IETF
should be involved and if there is such a working group it should be an
IETF working group sponsored by the opengroup. That is where all the real
experts are.

Alan
--
"The IETF already has more than enough RFCs that codify the obvious, make
stupidity illegal, support truth, justice, and the IETF way, and generally
demonstrate the author is a brilliant and valuable Contributor to The
Standards Process." -- Vernon Schryver
