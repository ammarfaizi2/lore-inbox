Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUCXUA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUCXUA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:00:27 -0500
Received: from tag.witbe.net ([81.88.96.48]:52998 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263107AbUCXUAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:00:19 -0500
Message-Id: <200403242000.i2OK0AA01266@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'John McCutchan'" <ttb@tentacle.dhs.org>, <rudi@lambda-computing.de>,
       <linux-kernel@vger.kernel.org>, <jamie@shareable.org>,
       <tridge@samba.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       <torvalds@osdl.org>, <alexl@redhat.com>, <rml@ximian.com>
Subject: Re: [RFC,PATCH] dnotify: enhance or replace?
Date: Wed, 24 Mar 2004 21:00:01 +0100
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <1080158032.30769.13.camel@vertex>
Thread-Index: AcQR2OU//01TzX6/Rfy7eU15H7PbBQAAV4sw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

> could be done. Inode numbers are not unique, but is there any 
> way to get
> a unique identifier on a file without using an open file? I have come
I wonder if adding to the inode number something like the device
id is not enough to create some "unique key"...

> up with a few ideas.. I don't think they are very good, but here is
> goes,
> 
> - When user passes fd to kernel to watch, the kernel takes over this
>   fd, making it invalid in user space ( I know this is a 
> terrible hack)
>   then when a volume is unmounted, the kernel can walk the list of 
>   open fd's using for notifacation and close them, before 
> attempting to
>   unmount.
No, this is bad, because it would require to use dedicated fd for
dnotify. If I open a file/directory, give it to dnotify, I don't
want to re-open it to use it, read it, or anything else...
 
> - The user passes a path to the kernel, the kernel does some work so
>   that it can track anything to do with that path, and again when
>   an unmount is called the kernel cleans up anything used for
>   notification. 
That sounds much better to me...

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 


