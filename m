Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWG3ST1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWG3ST1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWG3STZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:19:25 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:27866 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932405AbWG3STZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:19:25 -0400
Date: Sun, 30 Jul 2006 20:18:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
In-Reply-To: <44CCC4CA.6000208@argo.co.il>
Message-ID: <Pine.LNX.4.61.0607302018110.25626@yvahk01.tjqt.qr>
References: <44CC97A4.8050207@gmail.com> <44CCC4CA.6000208@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel_fpu_begin();
> c = d * 3.14;
> kernel_fpu_end();

static inline void kernel_fpu_begin() {
    ...
    preempt_disable();
    ...
}


Jan Engelhardt
-- 
