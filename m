Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbTH0Xji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 19:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTH0Xji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 19:39:38 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:19846 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262455AbTH0Xjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 19:39:37 -0400
Date: Thu, 28 Aug 2003 00:39:03 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Timo Sirainen <tss@iki.fi>
Cc: root@chaos.analogic.com, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030827233903.GB3759@mail.jlokier.co.uk>
References: <Pine.LNX.4.53.0308270925550.278@chaos> <A43789CE-D89E-11D7-9D97-000393CC2E90@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A43789CE-D89E-11D7-9D97-000393CC2E90@iki.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Sirainen wrote:
> Maybe it would be possible to use some kind of error detection 
> checksums which would guarantee that the data either is valid or isn't, 
> regardless of the order in which it is written. I don't really know how 
> that could be done though.

You can use a strong checksum like MD5, if that is really faster than
locking.  (Over NFS it probably is faster than fcntl()-locking, for
small data blocks).

-- Jamie
