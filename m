Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266203AbUG0QOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266203AbUG0QOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUG0QOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:14:18 -0400
Received: from mail.gmx.de ([213.165.64.20]:38105 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266203AbUG0QOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:14:16 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SiS900: NULL pointer encountered in Rx ring, skipping
Date: Tue, 27 Jul 2004 18:14:57 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Daniele Venzano <webvenza@libero.it>
References: <200407232052.06616.dominik.karall@gmx.net> <41067418.9020000@pobox.com>
In-Reply-To: <41067418.9020000@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271814.59859.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 17:26, Jeff Garzik wrote:
> Dominik Karall wrote:
> > After a few hours my network doesn't work on my laptop. There appear a
> > lot of those messages:
> >
> > eth0: NULL pointer encountered in Rx ring, skipping
> > eth0: NULL pointer encountered in Rx ring, skipping
> > eth0: NULL pointer encountered in Rx ring, skipping
> > eth0: NULL pointer encountered in Rx ring, skipping
> > eth0: NULL pointer encountered in Rx ring, skipping
> > eth0: NULL pointer encountered in Rx ring, skipping
> > eth0: NULL pointer encountered in Rx ring, skipping
> > eth0: NULL pointer encountered in Rx ring, skipping
> > eth0: NULL pointer encountered in Rx ring, skipping
> > eth0: NULL pointer encountered in Rx ring, skipping
> >
> > It works again after restarting network. I'm using 2.6.8-rc2 now. It was
> > the same problem in 2.6.7, but I didn't test it with earlier kernels.
>
> A NULL appears when the machine is temporarily unable to allocate room
> for a new skb.  Your machine's atomic memory pools are getting too low...
>
> 	Jeff

Yes, I took a look at the code and found the debug message. But isn't there 
any way to avoid network stop working? Because after a network restart it 
works again, maybe there could be used any "soft reset" to make network 
working again after such an error.

Dominik
