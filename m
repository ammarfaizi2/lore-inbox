Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTEPFzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 01:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTEPFzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 01:55:36 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:55405 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264300AbTEPFze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 01:55:34 -0400
Date: Thu, 15 May 2003 23:10:00 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jordan Breeding <jordan.breeding@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com, Greg KH <greg@kroah.com>
Subject: Re: 2.5.69-mm5 errors in dmesg
Message-Id: <20030515231000.48497801.akpm@digeo.com>
In-Reply-To: <20030516054141.17385.qmail@web80105.mail.yahoo.com>
References: <20030516054141.17385.qmail@web80105.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2003 06:08:21.0134 (UTC) FILETIME=[8D3CEAE0:01C31B71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding <jordan.breeding@sbcglobal.net> wrote:
>
> Hello,
> 
>   When booting 2.5.69-mm5 I have two errors showing up
> in dmesg, the first is the usb irq handler message
> below which is listed multiple times at boot:
> 
> irq 16: nobody cared!
> ...
> handlers:
> [<f03c3162>] (usb_hcd_irq+0x0/0x58)

Well darn.  Surely usb_hcd_irq() is coded correctly.

Maybe there is something fishy going on in the USB state machinery.

We'll hide these warnings soon, so don't worry about it too much.


>   The second error message is a message from the
> aic7xxx driver which I have seen before from some of
> Justin's updates, I only get this error from my
> Maxtor(Quantum) Atlas 10k III:
> 
> (scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
> (scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
> as error
> (scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
> (scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
> as error

Perhaps Justin can comment.

