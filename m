Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbUJXUPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUJXUPI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbUJXUPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:15:08 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:17829
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261610AbUJXUPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:15:00 -0400
Subject: Re: [PATCH] SCSI: Replace semaphores with wait_even
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, SCSI <linux-scsi@vger.kernel.org>
In-Reply-To: <1098647869.10824.247.camel@mulgrave>
References: <1098300579.20821.65.camel@thomas>
	 <1098647869.10824.247.camel@mulgrave>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 24 Oct 2004 22:06:54 +0200
Message-Id: <1098648414.22387.46.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-24 at 15:57 -0400, James Bottomley wrote:
> On Wed, 2004-10-20 at 15:29, Thomas Gleixner wrote:
> > 
> > Use wait_event instead of semaphores. Semaphores are slower
> > and trigger owner conflicts during semaphore debugging.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Ingo Molnar <mingo@elte.hu>
> > ---
> 
> There's something deeply wrong with this.  It causes a boot hang in my
> scsi test systems.

Hmm, strange. It works on two systems here and others using this
modification had no problem either. 
I will check again.

tglx




