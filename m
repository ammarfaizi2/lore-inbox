Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271195AbTHCOZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 10:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271196AbTHCOZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 10:25:56 -0400
Received: from AMarseille-201-1-2-252.w193-253.abo.wanadoo.fr ([193.253.217.252]:10024
	"EHLO gaston") by vger.kernel.org with ESMTP id S271195AbTHCOZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 10:25:55 -0400
Subject: Re: IDE locking problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Jens Axboe <axboe@suse.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F2D1884.3010001@colorfullife.com>
References: <3F2D1884.3010001@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059920721.3524.137.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 16:25:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The last step is bad - sooner or later the queue will be kfreed, and if 
> there are bozos around that still have references, they would access 
> random memory. It must be guaranteed that all references expired before 
> the tear down begins. Just leaving a dead flag set is not sufficient.

Jens ? I see no refcounting of the queue, but then we enter the
deep guts of the block layer and all this is pretty much obscure
to me. What can be done here ?

Ben.

