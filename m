Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVL3PHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVL3PHu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 10:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVL3PHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 10:07:49 -0500
Received: from [81.2.110.250] ([81.2.110.250]:190 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750827AbVL3PHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 10:07:48 -0500
Subject: Re: [PATCH 2.6.15-rc7-git3 1/3] sata_promise: add correct
	read/write of hotplug registers for SATAII devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lukasz Kosewski <lkosewsk@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <355e5e5e0512291523h508fe0c8j459a9377d52d5529@mail.gmail.com>
References: <355e5e5e0512291523h508fe0c8j459a9377d52d5529@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Dec 2005 15:09:07 +0000
Message-Id: <1135955347.28365.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-29 at 18:23 -0500, Lukasz Kosewski wrote:
> This patch adds support for correctly masking out and knowing about
> hotplug events on Promise SATAII150 Tx4/Tx2 Plus controllers.

Please call the core API ata_ not sata_. Many PATA controllers support
device hotplug or warmplug. (warmplug -> tell the OS first then unplug
then plug then tell the OS)

Alan
