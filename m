Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965921AbWKHPsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965921AbWKHPsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965926AbWKHPsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:48:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53709 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965921AbWKHPsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:48:46 -0500
Subject: Re: S2RAM and PCI quirks
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1163000705.23956.18.camel@localhost.localdomain>
References: <1163000705.23956.18.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 16:48:44 +0100
Message-Id: <1163000924.3138.342.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 15:45 +0000, Alan Cox wrote:
> I'm tracing down a case where suspend to ram/resume from RAM causes
> horrible corruption but not immediately. From a PCI dump it appears that
> we are not running the PCI quirks again on the S2RAM resume. Is this
> actually the case or am I missing something scanning through the code.
> If it is the case then we have multiple corruptors lurking because the
> PCI config restore doesn't cover the special registers that need poking
> in some cases.

at the same time I'm not 100% convinced it's ok to always run all quirks
at resume, for one the difference is that there now is a driver active
owning the device... Almost sounds like having a per quirk flag stating
"run at resume" is needed ;-(

(also I think the quirks are currently __init but that's relatively easy
to fix)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

