Return-Path: <linux-kernel-owner+w=401wt.eu-S1751170AbXAIJAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbXAIJAr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbXAIJAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:00:47 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:9259 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbXAIJAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:00:46 -0500
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH 0/5] fixing errors handling during pci_driver resume stage 
From: Dmitriy Monakhov <dmonakhov@openvz.org>
Date: Tue, 09 Jan 2007 12:00:49 +0300
Message-ID: <87wt3wmv5q.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where are several places where errors ignored during pci_driver resume stage.
In most most cases return value of 'pci_enable_device()' was ignored.
drivers from such subsystems affected:
 - ata
 - fusion
 - ide
 - mmc
 - net
 - parisc
 - parport
 - pci
 - serial

