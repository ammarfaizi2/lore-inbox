Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUJFNY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUJFNY1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUJFNY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:24:27 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:44412 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267212AbUJFNYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:24:25 -0400
Subject: Re: Badness in enable_irq with 2.6.9-rc3-mm2-vp-t1
From: Paul Fulghum <paulkf@microgate.com>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041006151014.5c7de38e.mdeboer@iua.upf.es>
References: <20041006145546.1a611d27.mdeboer@iua.upf.es>
	 <1097067996.1990.2.camel@deimos.microgate.com>
	 <20041006151014.5c7de38e.mdeboer@iua.upf.es>
Content-Type: text/plain
Message-Id: <1097069031.1990.9.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 08:23:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 08:10, Maarten de Boer wrote:
> > It is only a warning and the e100 will
> > continue to work.
> 
> Hm, for me it didn't. To be more precise, configuring networking with
> DHCP failed. But maybe that problem is somewhere else.

The warning is caused by calling enable_irq()
when the interrupt enable depth is already 0
(interrupt is already enabled).

A couple of people, including me, have reported
this warning. The adapter continues to work.
My understanding of the problem is that it
is a warning only.

Do you see the interrupt count from /proc/interrupts
for the e100 increasing?

-- 
Paul Fulghum
paulkf@microgate.com

