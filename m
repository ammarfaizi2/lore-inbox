Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWHLVrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWHLVrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422707AbWHLVrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:47:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:6708 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422672AbWHLVrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:47:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=UZp94pTrWFmNuuA7ilNBxJ6wFiPkZG5+iJmdcHny9SJH6/i5EsRLM4D3bWgHQ9CJqLQR+okNf6ov7LeF9DzuexTrV1nFgL2EPFpY69aP0grQJLc1UoVGmRlfOR80th44p+JhW0L6APEJi89s6JMIlYWwYhtRIegvQXGZZTTjyBQ=
Date: Sun, 13 Aug 2006 01:47:09 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       "Ian E. Morgan" <imorgan@webcon.ca>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Neverending module_param() bugs
Message-ID: <20060812214709.GC6252@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone think of a way to explicitly tell driver author that last
argument of module_param is PERMISSIONS, not default value? It's late
here I can't. Preferably resulting in compilation failure.

drivers/acpi/sbs.c:101:module_param(capacity_mode, int, CAPACITY_UNIT);
drivers/acpi/sbs.c:102:module_param(update_mode, int, UPDATE_MODE);
drivers/acpi/sbs.c:103:module_param(update_info_mode, int, UPDATE_INFO_MODE);
drivers/acpi/sbs.c:104:module_param(update_time, int, UPDATE_TIME);
drivers/acpi/sbs.c:105:module_param(update_time2, int, UPDATE_TIME2);
drivers/char/watchdog/sbc8360.c:203:module_param(timeout, int, 27);

P.S.: drivers/media/video/tuner-simple.c:13:module_param(offset, int, 0666);
								      ^^^^

