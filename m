Return-Path: <linux-kernel-owner+w=401wt.eu-S932583AbXAHINF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbXAHINF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbXAHINF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:13:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56158 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626AbXAHIND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:13:03 -0500
Date: Mon, 8 Jan 2007 08:12:59 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Hua Zhong <hzhong@gmail.com>, "'Christoph Hellwig'" <hch@infradead.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Message-ID: <20070108081259.GD17561@ftp.linux.org.uk>
References: <000501c732f9$7e3386a0$0200a8c0@nuitysystems.com> <110013.54208.qm@web55614.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <110013.54208.qm@web55614.mail.re4.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 12:05:59AM -0800, Amit Choudhary wrote:
 
> Attached is some code from the kernel. Expanded KFREE() has been used atleast 1000 times in the
> kernel. By your logic, everyone is stupid in doing so. Something has been done atleast 1000 times
> in the kernel, that looks okay. But consolidating it at one place does not look okay. I am listing
> some of the 1000 places where KFREE() has been used. All this code have been written by atleast 50
> different people. From your logic they were doing "silly" things.

Very likely.  Some of that is a cargo-cult programming, some is explicit
logics controlling cleanup later on, some is outright racy (== everything
that leaves kfree()'d pointer in shared data structure for a while).
