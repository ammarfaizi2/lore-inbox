Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263368AbTH0MwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbTH0MwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:52:12 -0400
Received: from ip213-185-36-189.laajakaista.mtv3.fi ([213.185.36.189]:59964
	"EHLO oma.irssi.org") by vger.kernel.org with ESMTP id S263368AbTH0MwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:52:10 -0400
Subject: Re: Lockless file reading
From: Timo Sirainen <tss@iki.fi>
To: Martin Konold <martin.konold@erfrakon.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308271442.48672.martin.konold@erfrakon.de>
References: <1061987837.1455.107.camel@hurina>
	 <200308271442.48672.martin.konold@erfrakon.de>
Content-Type: text/plain
Message-Id: <1061988729.1457.115.camel@hurina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 27 Aug 2003 15:52:09 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 15:42, Martin Konold wrote:
> > The question is what can happen if I read() a file that's being
> > simultaneously updated by a write() in another process?
> 
> The behaviour is undefined.

So it's not such a good idea then? Hmh.. That'd solve a lot of problems
for me.
 
> > 123 over XXX, is it possible that read() returns 1X3 in some conditions?
> 
> Yes. The actual order stuff is written to the disk is not guaranteed.

It doesn't matter when it's actually written to disk, if it's only seen
by read().


