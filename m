Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUEKH23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUEKH23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 03:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUEKH23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 03:28:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:51130 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262256AbUEKH17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 03:27:59 -0400
Date: Tue, 11 May 2004 00:27:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Gary Wong <gtw@cs.bu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Segmentation fault in i810_audio.c:__i810_update_lvi
Message-Id: <20040511002728.46e05e4c.akpm@osdl.org>
In-Reply-To: <20040510123607.T9078@cs.bu.edu>
References: <20040510123607.T9078@cs.bu.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gary Wong <gtw@cs.bu.edu> wrote:
>
> I believe that one of two fixes should be applied: either the
>  SNDCTL_DSP_SETTRIGGER ioctl handling should not enable the
>  PCM_ENABLE_{IN,OUT}PUT bits unless file->f_mode is compatible,
>  or i810_release() should ignore the PCM_ENABLE_* bits without
>  the corresponding FMODE_*.

The first option sounds more appropriate but I wonder if it could break
existing applications?  Probably not, if it oopses.

Let's try option #1, please.

