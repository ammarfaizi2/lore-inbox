Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264820AbUD1OYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264820AbUD1OYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264822AbUD1OYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:24:39 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:6416 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264820AbUD1OYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:24:32 -0400
Date: Wed, 28 Apr 2004 15:24:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: csg69@mailbox.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in include file!?
Message-ID: <20040428152430.A343@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, csg69@mailbox.hu,
	linux-kernel@vger.kernel.org
References: <20040426203710.GA3005@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040426203710.GA3005@matrix>; from csg69@mailbox.hu on Mon, Apr 26, 2004 at 10:37:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 10:37:10PM +0200, csg69@mailbox.hu wrote:
> Finally I solved the problem by changing the value
> in cdrtools-2.00.3/DEFAULTS/Defaults.linux
> 
> from the original:
> DEFINCDIRS=	$(SRCROOT)/include /usr/src/linux/include
> 
> to:
> DEFINCDIRS=	$(SRCROOT)/include /usr/include
> 
> 
> It seems that in /usr/include/scsi/scsi.h everything is OK...
> 
> 
> It may be the error of the makefiles or the kernel include files...
> 
> Joerg Schilling (schilling@fokus.fraunhofer.de) advised me
> to send to you this report.
> He thinks this is a bug in kernel include files.

It's a bug in his package actually - userspace programs should not
use kernel headers.  Your change to the makefile is the correct fix.

