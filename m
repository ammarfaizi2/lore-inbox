Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbUB0FAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 00:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUB0FAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 00:00:31 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:64263 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id S261666AbUB0FA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 00:00:28 -0500
From: Stuart Young <sgy-lkml@amc.com.au>
To: MP M <mageshmp2003@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: help in TCP checksum offload , TSO and zero copy
Date: Fri, 27 Feb 2004 16:00:30 +1100
User-Agent: KMail/1.5.4
References: <20040226185219.70474.qmail@web21407.mail.yahoo.com>
In-Reply-To: <20040226185219.70474.qmail@web21407.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402271556.09127.sgy-lkml@amc.com.au>
Organization: AMC Enterprises P/L
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 05:52 am, MP M wrote:

> Next I set the tx and rx checksum on e1000 card using
> ethtool , and repeated the above test with ttcp
> utility .Since the content size is same and with tx/rx
> checksum off on e1000 , I expected the time duaration
> of data transfer from server to client to be x+some
> delta . But surprisingly I am noticing the data
> transfer at lesser time than x .(ie faster than before
> with tx/rx checksum off on e1000 ) .
>
> I would appreciate if anyone could shed some light on
> this odd behaviour .

If you only ran the test once, could this be due to disk access and caching of 
the original command by the block layer?

You'd be better off getting rid of tar from the equation, by creating the tar 
output on disk, and then copying that to null to prime the disk cache before 
you perform your tests. Avoid any other disk activity on the box, as it could 
flush the disk cache and change the results.


