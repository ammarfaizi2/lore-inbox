Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265781AbTFSUnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbTFSUnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:43:22 -0400
Received: from almesberger.net ([63.105.73.239]:64263 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265781AbTFSUnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:43:18 -0400
Date: Thu, 19 Jun 2003 17:53:11 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Olivier Galibert <galibert@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030619175311.D6248@almesberger.net>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <20030612150335.6710a94f.akpm@digeo.com> <1055493636.5163.8.camel@dhcp22.swansea.linux.org.uk> <20030613091400.GB78853@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613091400.GB78853@dspnet.fr.eu.org>; from galibert@pobox.com on Fri, Jun 13, 2003 at 11:14:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> "Netlink is not a reliable protocol." sez the manpage.
> 
> That sounds a little ridiculous for a local kernel<->user message
> protocol.

There are many way of being unreliable. If it means "bad things
happen and nobody is told about it", then yes, this would be
strange in this context. Howver, "loss due to congestion" is a
perfectly reasonable behaviour (*), and netlink indicates when
this has occurred.

If you get more events than you can queue or compress (e.g. if
you have on/off events but are only interested in the current
status, you could aggregate any number of such events in just
one bit), congestion is possible.

> Having to manage acks on that kind of communication is both
> painful and quasi-untestable.

<ObPlug>
Ha ! That's exactly the kind of stuff I'm writing umlsim for :-)
http://umlsim.sourceforge.net/
</ObPlug>

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
