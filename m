Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbTCOTPf>; Sat, 15 Mar 2003 14:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbTCOTPe>; Sat, 15 Mar 2003 14:15:34 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:13982 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261528AbTCOTPe>; Sat, 15 Mar 2003 14:15:34 -0500
Message-Id: <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: dan carpenter <d_carpenter@sbcglobal.net>
To: Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Any hope for ide-scsi (error handling)?
Date: Sat, 15 Mar 2003 03:05:46 +0100
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
Cc: wrlk@riede.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 March 2003 07:55 pm, Zwane Mwaikambo wrote:
>
> bad: scheduling while atomic!
> Call Trace:
>

   887          spin_lock_irqsave(&ide_lock, flags);
   888          while (HWGROUP(drive)->handler) {
   889                  HWGROUP(drive)->handler = NULL;
   890                  schedule_timeout(1);
   891          }

Here is at least one bad call to schedule() in 
static int idescsi_reset (Scsi_Cmnd *cmd)

regards,
dan



