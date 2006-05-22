Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWEVSyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWEVSyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWEVSyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:54:46 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:13184 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750754AbWEVSyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:54:45 -0400
Subject: Re: Was change to ip_push_pending_frames intended to break
	udp	(more specifically, WCCP?)
From: Vlad Yasevich <vladislav.yasevich@hp.com>
To: Rick Jones <rick.jones2@hp.com>
Cc: Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <4472078D.8010706@hp.com>
References: <20060520191153.GV3776@stingr.net>
	 <20060520140434.2139c31b.akpm@osdl.org>
	 <1148322152.15322.299.camel@galen.zko.hp.com>  <4472078D.8010706@hp.com>
Content-Type: text/plain
Organization: Linux and Open Source Lab
Date: Mon, 22 May 2006 14:54:43 -0400
Message-Id: <1148324083.15323.325.camel@galen.zko.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 11:48 -0700, Rick Jones wrote:
> > IP id is set to 0 on unconnected sockets when the DF bit is set (path
> > mtu discovery is enabled).  Try issuing a connect() in your application
> > and see if the ids are increasing again.
> 
> ID of zero again?  I thought that went away years ago?  Anyway, given 
> the number of "helpful" devices out there willing to clear the DF bit, 
> fragment and forward, perhaps always setting the IP ID to 0, even if DF 
> is set, isn't such a good idea?

Hey... I just report what I find... ;)

I had to look at this code a bit for some SCTP cases as well and this
seems to be how it works.  Here a comment from the code for the case
of the DF bit being set
    /* This is only to work around buggy Windows95/2000
     * VJ compression implementations.  If the ID field
     * does not change, they drop every other packet in
     * a TCP stream using header compression.
     */

-vlad

> 
> rick jones
> 

