Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUDOOdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbUDOOdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:33:23 -0400
Received: from tench.street-vision.com ([212.18.235.100]:42679 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262022AbUDOOdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:33:21 -0400
Subject: Re: poor sata performance on 2.6
From: Justin Cormack <justin@street-vision.com>
To: kos@supportwizard.com
Cc: Ryan Geoffrey Bourgeois <rgb005@latech.edu>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <200404151826.54488.kos@supportwizard.com>
References: <200404150236.05894.kos@supportwizard.com>
	 <200404151734.03786.kos@supportwizard.com>
	 <1082037632.19567.72.camel@lotte.street-vision.com>
	 <200404151826.54488.kos@supportwizard.com>
Content-Type: text/plain
Message-Id: <1082039593.19568.75.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Apr 2004 15:33:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 15:26, Konstantin Sobolev wrote:
> On Thursday 15 April 2004 18:00, Justin Cormack wrote:
> > hmm, odd. I get 50MB/s or so from normal (7200, 8MB cache) WD disks, and
> > Seagate from the same controller. Can you send lspci, /proc/interrupts
> > and dmesg...
> 
> Attached are files for 2.6.5-mm5 with highmem, ACPI and APIC turned off.

ah. Make a filesystem on it and mount it and try again. I see you have
no partition table and so probably no filesystem. This means the block
size is set to default 512byte not 4k which makes disk operations slow.
Any filesystem should default to block size of 4k, eg ext2.

Justin


