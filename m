Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTFXIzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 04:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbTFXIzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 04:55:16 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:30942 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261180AbTFXIzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 04:55:13 -0400
Subject: Re: matroxfb console oops in 2.4.2x
From: David Woodhouse <dwmw2@infradead.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
In-Reply-To: <4E2D2240020@vcnet.vc.cvut.cz>
References: <4E2D2240020@vcnet.vc.cvut.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1056445757.29264.384.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 24 Jun 2003 10:09:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 20:45, Petr Vandrovec wrote:
> This one is culprit. If you'll comment this message out, it will not
> crash.

As discussed, this is true but if anyone _else_ happens to call printk
during the same period, it'll still crash. 

Matroxfb is registering a screen for which it's not yet willing to
attempt output -- and taking out this printk only serves to fix the
coincidence which makes it 100% reproducible -- the thing is still
broken without that printk.

-- 
dwmw2

