Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbULBXcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbULBXcr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 18:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbULBXcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 18:32:41 -0500
Received: from canuck.infradead.org ([205.233.218.70]:35847 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261803AbULBXch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 18:32:37 -0500
Subject: Re: Designing Another File System
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Valdis.Kletnieks@vt.edu, John Richard Moser <nigelenki@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101836768.25629.66.camel@localhost.localdomain>
References: <41ABF7C5.5070609@comcast.net>
	 <200411301828.iAUISgf8031548@turing-police.cc.vt.edu>
	 <1101836768.25629.66.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 23:32:03 +0000
Message-Id: <1102030324.18212.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 17:46 +0000, Alan Cox wrote:
> On Maw, 2004-11-30 at 18:28, Valdis.Kletnieks@vt.edu wrote:
> > On Mon, 29 Nov 2004 23:32:05 EST, John Richard Moser said:
> > they punt on the issue of over-writing a sector that's been re-allocated by
> > the hardware (apparently the chances of critical secret data being left in
> > a reallocated block but still actually readable are "low enough" not to worry).
> 
> I guess they never consider CF cards which internally are log structured
> and for whom such erase operations are very close to pointless.

Actually for the cases where we do that translation layer in software
ourselves to emulate a block device, it would be really nice to know
that a sector is unused an hence that we no longer have to keep its old
stale contents when we garbage-collect.

-- 
dwmw2

