Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266710AbRGXCAT>; Mon, 23 Jul 2001 22:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbRGXCAJ>; Mon, 23 Jul 2001 22:00:09 -0400
Received: from zok.SGI.COM ([204.94.215.101]:17123 "EHLO zok.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S266583AbRGXB75>;
	Mon, 23 Jul 2001 21:59:57 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Olaf Hering <olh@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: new scsi hardware detection in 2.4.7(pre) 
In-Reply-To: Your message of "Mon, 23 Jul 2001 17:10:19 +0200."
             <20010723171019.A18135@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Jul 2001 11:59:54 +1000
Message-ID: <22072.995939994@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001 17:10:19 +0200, 
Olaf Hering <olh@suse.de> wrote:
>I get this on non-scsi systems with scsi compiled into the kernel:
>
>SCSI subsystem driver Revision: 1.00
>request_module[scsi_hostadapter]: Root fs not mounted
>request_module[scsi_hostadapter]: Root fs not mounted
>request_module[scsi_hostadapter]: Root fs not mounted

The SCSI midlayer is trying to load the SCSI host adapter, that is an
unavoidable side effect of including SCSI support.  Because no adapter
is found, kmod tries to automatically load a module that can find a
host adapter.  The "Root fs not mounted" message occurs when you try to
load any module before / is mounted.

