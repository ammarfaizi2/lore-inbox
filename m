Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTH1KKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbTH1KHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:07:33 -0400
Received: from ip213-185-36-189.laajakaista.mtv3.fi ([213.185.36.189]:53534
	"EHLO oma.irssi.org") by vger.kernel.org with ESMTP id S262288AbTH1J1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:27:39 -0400
Subject: Re: Lockless file reading
From: Timo Sirainen <tss@iki.fi>
To: Martin Konold <martin.konold@erfrakon.de>
Cc: Jamie Lokier <jamie@shareable.org>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200308281113.59112.martin.konold@erfrakon.de>
References: <3217CEE6-D906-11D7-A165-000393CC2E90@iki.fi>
	 <200308281113.59112.martin.konold@erfrakon.de>
Content-Type: text/plain
Message-Id: <1062062858.1454.254.camel@hurina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 12:27:38 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 12:13, Martin Konold wrote:
> > How about checksum[n] = data[n-1] ^ data[n]? That looks like it would
> 
> I propose you first make some benchmarks and try to figure out how big the 
> actual overhead of locking really is. I can easily assume that your 
> "solution" is actually slower than a simple mechanism/semaphore. 

It's not about CPU usage. It's mostly about being able to modify the
file even when there's thousands of simultaneous readers that could
otherwise keep the file locked almost constantly.

Also it'd be nice to support NFS with .lock files since no-one really
uses lockd.


