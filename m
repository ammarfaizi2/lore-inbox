Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbTGOPrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbTGOPrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:47:43 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:65257 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268751AbTGOPrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:47:35 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.9560.602996.872584@gargle.gargle.HOWL>
Date: Tue, 15 Jul 2003 11:01:28 -0500
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com, bob@watson.ibm.com
Subject: Re: [RFC][PATCH 0/5] relayfs
In-Reply-To: <1058282847.375.3.camel@sherbert>
References: <16148.6807.578262.720332@gargle.gargle.HOWL>
	<1058282847.375.3.camel@sherbert>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gianni Tedesco writes:
 > On Tue, 2003-07-15 at 16:15, Tom Zanussi wrote:
 > > The following 5 patches implement relayfs, adding a dynamic channel
 > > resizing capability to the previously posted version.
 > > 
 > > relayfs is a filesystem designed to provide an efficient mechanism for
 > > tools and facilities to relay large amounts of data from kernel space
 > > to user space.  Full details can be found in Documentation/filesystems/
 > > relayfs.txt.  The current version can always be found at
 > > http://www.opersys.com/relayfs.
 > 
 > Could this be used to replace mmap() packet socket, how does it compare?

I think so - you could send high volumes of packet traffic to a bulk
relayfs channel and read it from the mmap'ed relayfs file in user
space.  The Linux Trace Toolkit does the same thing with large volumes
of trace data - you could look at that code as an example
(http://www.opersys.com/relayfs/ltt-on-relayfs.html).

Tom


 > 
 > -- 
 > // Gianni Tedesco (gianni at scaramanga dot co dot uk)
 > lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
 > 8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D
 > 

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

