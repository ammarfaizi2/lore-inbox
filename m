Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUF2SjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUF2SjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUF2SjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:39:06 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:30868 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265909AbUF2Sis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:38:48 -0400
Date: Tue, 29 Jun 2004 20:38:47 +0200
From: bert hubert <ahu@ds9a.nl>
To: Debi Janos <debi.janos@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-ID: <20040629183847.GA9493@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Debi Janos <debi.janos@freemail.hu>, linux-kernel@vger.kernel.org
References: <20040629172815.GA6625@outpost.ds9a.nl> <freemail.20040529200446.32881@fm2.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <freemail.20040529200446.32881@fm2.freemail.hu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 08:04:46PM +0200, Debi Janos wrote:
> bert hubert <ahu@ds9a.nl> ?rta:
> .
> > 
> > Then attach both these files in a message, either to me or
> to the list.
> > 
> > This will allow us to see what is going on.
> 
> 
> dumps attached. thanks.

There is almost no difference in the trace, and it is very puzzling. Your
attachments will have been bounced by vger, so I suggest putting these
traces online somewhere.

The weird thing is that the packages.gentoo.org appears to be at fault. It
ignores your valid FIN packets, or at least, they appear to be valid to
ethereal.

There are three differences between these traces:
	1) The IP address of your computer
	2) In the non-working trace, your Mozilla does not pass a
	   'Cache-Control' HTTP header
	3) The broken trace has a timestamp wraparound on your side

Of note is that both gentoo and you set a non-standard MSS (I think).

Suggestions:
	1) turn off timestamps (echo 0 > /proc/sys/net/ipv4/tcp_timestamps)
	2) set your MTU to 1000 or so (ifconfig eth0 mtu 1000)

And try again.

Interesting case!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
