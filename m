Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWDLOVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWDLOVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 10:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWDLOVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 10:21:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12986 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751150AbWDLOVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 10:21:19 -0400
Subject: Re: HDIO_SCAN_HWIF causes hwif to "forget" PCI parent
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200604080030.07236.arvidjaar@mail.ru>
References: <200604080030.07236.arvidjaar@mail.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Apr 2006 15:30:17 +0100
Message-Id: <1144852217.1952.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-04-08 at 00:30 +0400, Andrey Borzenkov wrote:
> One of scripts called on Mandriva during suspend/resume calls hdparm -U for 
> hdc on suspend and hdparm -R on resume.

Thats not a good idea. These functions are not suitable for use with
anything but extremely specialised platforms and only when IDE is
quiescent, or on 2.4-ac.

Fix Mandriva not to vandalise the IDE configuration.

