Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTE1WVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbTE1WVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:21:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25812
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261265AbTE1WVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:21:53 -0400
Subject: RE: [BUGS] 2.5.69 syncppp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054157063.2279.2.camel@diemos>
References: <OPENKONOOJPFMJFAJLHAKEPCCBAA.paulkf@microgate.com>
	 <1053970962.16694.17.camel@dhcp22.swansea.linux.org.uk>
	 <1054157063.2279.2.camel@diemos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054157825.20725.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 May 2003 22:37:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-28 at 22:24, Paul Fulghum wrote:
> The spinlock in cp_timeout() does not synchronize
> with input from sppp_input(), but *does* synchronize
> with sppp_keepalive() which is run off another timer.

In which case you can also use the del_timer return to do
a del_timer_sync/add_timer based protection in some 
situations

