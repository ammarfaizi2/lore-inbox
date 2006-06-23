Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWFWNZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWFWNZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWFWNZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:25:04 -0400
Received: from [212.33.161.28] ([212.33.161.28]:27402 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751486AbWFWNZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:25:03 -0400
From: Al Boldi <a1426z@gawab.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
Date: Fri, 23 Jun 2006 16:25:39 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200606211715.58773.a1426z@gawab.com> <200606222036.45081.a1426z@gawab.com> <449ADCB2.4000006@gmail.com>
In-Reply-To: <449ADCB2.4000006@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200606231625.39904.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
>
> (vgacon's screenbuffer is video RAM while the rest of the console drivers
> have it in system RAM. But you can have vgacon and fbcon compiled at the
> same time, for example, and this basically screws up the screen accessors,
> especially in non-x86 archs.)
>
> So a revamp of vgacon may be necessary, by placing the screen buffer in
> system RAM. This will entail a lot of work, so the revamp will take some
> time.

Thanks for looking into this.

> > VIA has a separate driver, couldn't this be merged with mainline?
>
> Sure, as long as it's GPL-compatible, properly written, and correctly
> Signed-off.

Attached below is their license.  Is it GPL-compatible?

Thanks!

--
Al

---
/*
 * Copyright 1998-2006 VIA Technologies, Inc. All Rights Reserved.
 * Copyright 2001-2006 S3 Graphics, Inc. All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sub license,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the
 * next paragraph) shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

(... and at the end of viafbdev.c it says this ...)

#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,9)
    MODULE_LICENSE("GPL");
#endif

