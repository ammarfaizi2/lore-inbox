Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFAEKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFAEKW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 00:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVFAEKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 00:10:22 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:19666 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261236AbVFAEKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 00:10:18 -0400
X-ORBL: [63.202.173.158]
Date: Tue, 31 May 2005 21:10:11 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Igor Schein <igor@txc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64bit filesize limit on a 32bit linux
Message-ID: <813690.12dc80612fe40b20692639cdd7080a22.ANY@taniwha.stupidest.org>
References: <20050531193533.GO1337@txc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531193533.GO1337@txc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 03:35:33PM -0400, Igor Schein wrote:

> # ulimit -f `echo 2^22-1|bc`;ulimit -f
> 4194303
> # ulimit -f `echo 2^22|bc`;ulimit -f
> unlimited
> # uname -r
> 2.6.11-1.1290_FC4

> I need to limit users to 5GB per file instead of 4GB.  Do I need any
> kernel patches or can it somehow be done in user space?

The syscall (and also glibc glue) for this only support 32-bit values.
It's probably not hard to make a 64-bit version of these system calls
(I'm not sure about the glibc changes though).
