Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTILNmB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 09:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbTILNmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 09:42:00 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:64004 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261611AbTILNl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 09:41:58 -0400
Subject: Re: [PATCH] NCR53c406a.c warning
From: James Bottomley <James.Bottomley@steeleye.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0309110836030.1879-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0309110836030.1879-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Sep 2003 09:41:49 -0400
Message-Id: <1063374111.1767.2.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-11 at 02:37, Geert Uytterhoeven wrote:
> NCR53c406a: Apparently wait_intr() is unused, so remove it.

It is currently unused.  However, the reason is that we removed the scsi
command method that allows polled operation in a driver (this routine is
actually polling the interrupt port on the chip).

I'd like to wait a while to see if anyone still needs this mode when 2.6
gets a wider test audience.  If you wish, you can surround the routine
with #if 0 and a comment saying we can junk it later if it really is
unnecessary.

Thanks,

James


