Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVCWDcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVCWDcX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 22:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVCWDcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 22:32:23 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:18321 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261976AbVCWDcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 22:32:21 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: lseek on /proc/kmsg
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-os <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Wed, 23 Mar 2005 03:22:36 +0100
References: <fa.k09kbma.1kkmjhe@ifi.uio.no> <fa.j3anmof.1b06cjp@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DDvW2-0001ml-68@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> +static loff_t kmsg_seek(struct file *filp, loff_t offset, int origin) {
> +    if(origin != 2 /* SEEK_END */ || offset < 0) { return -ESPIPE; }
                                              ^^^

"Allow" seeking past the end of the buffer?

