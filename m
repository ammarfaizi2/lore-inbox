Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTIEEf0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 00:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTIEEfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 00:35:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:22179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262078AbTIEEfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 00:35:22 -0400
Date: Thu, 4 Sep 2003 21:35:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Daniel Phillips <phillips@arcor.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Jamie Lokier <jamie@shareable.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix remap of shared read only mappings
In-Reply-To: <1062724028.23305.14.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0309042133580.20188-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Sep 2003, Alan Cox wrote:
> 
> NFS ?

On a local machine, yes.

Clearly NFS will _not_ be cache-coherent over a network. But even NFS is
supposed to be cache-coherent on a per-client basis. 

Networking is _not_ an excuse for not doing that right.

		Linus

