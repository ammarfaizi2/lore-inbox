Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUIOWod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUIOWod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUIOWnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:43:50 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:55747 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267478AbUIOWmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:42:18 -0400
Subject: Re: [PATCH-NEW] allow root to modify raw scsi command permissions
	list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: Peter Jones <pjones@redhat.com>, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040915230813.6eac1d04.Ballarin.Marc@gmx.de>
References: <1095173470.5728.3.camel@localhost.localdomain>
	 <20040915230813.6eac1d04.Ballarin.Marc@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095284325.20749.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 22:38:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-15 at 22:08, Marc Ballarin wrote:
> Hi,
> this is a modified version of the previous patch.

You need to check for capable(CAP_SYS_RAWIO) otherwise you elevate
anyone with access bypass capabilities to CAP_SYS_RAWIO equivalent
powers.

