Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVGEQPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVGEQPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVGEQON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:14:13 -0400
Received: from [81.2.110.250] ([81.2.110.250]:16287 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261859AbVGEQDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 12:03:32 -0400
Subject: Re: ide-cd and bad sectors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42C6A12A.8030009@free.fr>
References: <42C6A12A.8030009@free.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1120579233.23118.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Jul 2005 17:00:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-07-02 at 15:14, matthieu castet wrote:
> Also I was wondering if all the sector that ide-cd failed to read are 
> bad sector, or if ide-cd failed to put the drive in a consistent state 
> for reading the next sector after corrupted one.

ide-cd wrongly errors all the sectors around an error, ide-scsi gets it
right if the IDE firmware does. I sent Bartlomiej patches to fix that
and I believe he accepted them

