Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTKQVbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTKQVbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:31:17 -0500
Received: from mx5.Informatik.Uni-Tuebingen.De ([134.2.12.32]:903 "EHLO
	mx5.informatik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S261868AbTKQVbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:31:14 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: alpha@steudten.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Re: BUG: Kernel Panic: kernel-2.6.0-test9-bk21  for alpha in scsi context ll_rw_blk.c
References: <3FB92938.8040906@steudten.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 17 Nov 2003 22:31:09 +0100
In-Reply-To: <3FB92938.8040906@steudten.com>
Message-ID: <87r806d6n6.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Steudten <alpha@steudten.com> writes:

> -> 0xfffffc0000476cb8 <__make_request+152>:        lds     $f31,0(t2)

The kernel is stupid, this is a prefetch, it should be totally ignored
if it is faulty. This is already handled for userspace accesses
IIRC... (I wonder why the PALcode doesn't already do that. Oh well.)

-- 
	Falk
