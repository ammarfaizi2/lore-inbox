Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267597AbUIPGRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267597AbUIPGRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUIPGRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:17:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5087 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267597AbUIPGRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:17:43 -0400
Date: Wed, 15 Sep 2004 23:17:36 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <benh@kernel.crashing.org>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] ub.c badness in current bk
Message-Id: <20040915231736.74556b17@lembas.zaitcev.lan>
In-Reply-To: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
References: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 12:06:01 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> usb 1-1: new full speed USB device using address 2
> ub: sizeof ub_scsi_cmd 60 ub_dev 924
> uba: device 2 capacity nsec 50 bsize 512
> uba: made changed
> uba: device 2 capacity nsec 126720 bsize 512
> uba: device 2 capacity nsec 126720 bsize 512
>  uba: uba1
>  uba: uba1
> kobject_register failed for uba1 (-17)
> Call trace:
>  [8000ba5c] dump_stack+0x18/0x28
>  [80132a04] kobject_register+0x68/0x6c
>  [80094e34] add_partition+0xdc/0x100
>  [80094ff8] register_disk+0x134/0x13c
>  [801866d4] add_disk+0x58/0x74
>  [c211a070] ub_probe+0x250/0x2c0 [ub]

I'll look tomorrow. These duplicated messages are suspicious, something
must be racing.

-- Pete
