Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbTE0W5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTE0W5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:57:04 -0400
Received: from dp.samba.org ([66.70.73.150]:53656 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264422AbTE0W5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:57:04 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16083.61404.354044.232004@nanango.paulus.ozlabs.org>
Date: Wed, 28 May 2003 09:08:12 +1000 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] fix controlfb and platinumfb drivers
In-Reply-To: <Pine.LNX.4.44.0305272328300.26160-100000@phoenix.infradead.org>
References: <16079.23061.979768.135318@argo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0305272328300.26160-100000@phoenix.infradead.org>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons writes:

> Applied. Tho it is strnage. You shouldn't need to call fb_set_var from the 
> driver. 

It's just convenient to use fb_set_var to get the hardware set to the
initial mode.  Would it be better to call controlfb_check_var,
controlfb_set_par, etc., directly?

Paul.
