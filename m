Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUHKK4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUHKK4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 06:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUHKK4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 06:56:11 -0400
Received: from the-village.bc.nu ([81.2.110.252]:27856 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268021AbUHKK4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 06:56:08 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nathan Bryant <nbryant@optonline.net>
Cc: "'James Bottomley'" <James.Bottomley@steeleye.com>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, jgarzik@pobox.com
In-Reply-To: <411960C3.5090107@optonline.net>
References: <411960C3.5090107@optonline.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092218000.18968.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 11 Aug 2004 10:53:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-11 at 00:56, Nathan Bryant wrote:
> This might help SATA drives, too, but I seem to remember that the SATA 
> layer doesn't properly emulate the SYNCHRONIZE_CACHE command.

That was something Mark Lord reported higher level I suspect - which is
that the scsi path is disabled before the sync cache command is sent so
the command is always errored before it hits the drive

