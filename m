Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265781AbUFDNX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265781AbUFDNX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 09:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUFDNX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 09:23:58 -0400
Received: from mail.ccur.com ([208.248.32.212]:45064 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265781AbUFDNX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 09:23:57 -0400
Date: Fri, 4 Jun 2004 09:23:55 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] NFS no longer updates file modification times appropriately
Message-ID: <20040604132355.GA31710@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1086297112.3659.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086297112.3659.3.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 05:11:52PM -0400, Trond Myklebust wrote:
> P? to , 03/06/2004 klokka 13:28, skreiv Joe Korty:
> >  Paraphrased from one of my inhouse customers: "The timestamp of an
> > NFS-mounted file does not change when written to, when the below test is
> > run on a 2.6.6-rc1 to 2.6.7-rc2 kernel.  The timestamp is appropriately
> > updated when the test is run on a 2.6.5 kernel.  This is with NFSv3.
> > The type of system serving up the files does not seem to be a factor."
> 
> NFS is only guaranteed to flush the file to disk when you do the
> close(). Your program will just result in a lot of cached writes right
> up until the moment it exits...
> 
> ...and no - we do not update timestamps on the client side when we cache
> the write, 'cos NFS does not provide any device for ensuring that clocks
> on client and server are synchronized.

Hi Trond,
 Thanks for the explanation.  What did 2.6.5 do differently that made it
appear to work?

Regards,
Joe
