Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWBHBNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWBHBNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 20:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWBHBNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 20:13:04 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19671 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030394AbWBHBNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 20:13:02 -0500
Subject: Re: [PATCH] new tty buffering locking fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1139347644.3174.16.camel@amdx2.microgate.com>
References: <200602032312.k13NCbWb012991@hera.kernel.org>
	 <20060207123450.GA854@suse.de>
	 <1139329302.3019.14.camel@amdx2.microgate.com>
	 <20060207171111.GA15912@suse.de>
	 <1139347644.3174.16.camel@amdx2.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Feb 2006 01:14:53 +0000
Message-Id: <1139361293.22595.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-07 at 15:27 -0600, Paul Fulghum wrote:
> Olaf:
> 
> Try this patch and let me know how it works.
> (it is against 2.6.16-rc2-git1)
> 
> This change prevents claiming a partially filled
> buffer if it has already been committed by the
> driver calling a tty scheduling function, but not
> yet processed by the tty layer.

Thats going to hurt memory consumption in the worst cases. Might be
better to document the sane behaviour and enforce it ?

