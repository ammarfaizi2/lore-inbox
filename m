Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTIHEKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 00:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTIHEKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 00:10:48 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:50426 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261929AbTIHEKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 00:10:46 -0400
Date: Sun, 7 Sep 2003 22:09:26 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Eric W. Biederman" <ebiederman@lnxi.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: How do I track TG3 peculiarities?
Message-ID: <20030907220926.G18482@schatzie.adilger.int>
Mail-Followup-To: "Eric W. Biederman" <ebiederman@lnxi.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	"David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <m31xuss0ht.fsf@maxwell.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m31xuss0ht.fsf@maxwell.lnxi.com>; from ebiederman@lnxi.com on Sun, Sep 07, 2003 at 04:21:50PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 07, 2003  16:21 -0600, Eric W. Biederman wrote:
> Below is one good oops we have captured.  I would have to check but
> I believe we have updated the tg3 driver in this instance to the
> one that comes with 2.4.23-pre3.
> 
> The very puzzling part is that in the crashes I don't see the tg3
> driver at all just the network stack.  All module addresses according
> to /proc/ksyms started with at 0xf8, and the tg3 driver was built as
> a module.
> 
> I have been having trouble understanding why skb_clone would be called
> to transmit a packet.  Any ideas?

Do you have the stack overflow checking enabled?  That has been a source
of problems for us.  It was especially difficult to reproduce, because it
only happened during a double interrupt.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

