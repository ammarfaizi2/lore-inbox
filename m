Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUIOXdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUIOXdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUIOX3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:29:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:61891 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267772AbUIOX0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:26:46 -0400
Subject: Re: [PATCH-NEW] allow root to modify raw scsi command permissions
	list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Jones <pjones@redhat.com>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095289404.20046.63.camel@localhost.localdomain>
References: <1095173470.5728.3.camel@localhost.localdomain>
	 <20040915230813.6eac1d04.Ballarin.Marc@gmx.de>
	 <1095284325.20749.8.camel@localhost.localdomain>
	 <1095289404.20046.63.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095287003.20754.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 23:23:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-16 at 00:03, Peter Jones wrote:
> > You need to check for capable(CAP_SYS_RAWIO) otherwise you elevate
> > anyone with access bypass capabilities to CAP_SYS_RAWIO equivalent
> > powers.
> 
> Do you mean in the ->store path?

Thats the one - otherwise you can add commands without the ability you'd
normally have to bypass

