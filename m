Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVDYSJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVDYSJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVDYSJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:09:20 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:29067 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262694AbVDYSJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 14:09:10 -0400
Subject: Re: [PATCH scsi-misc-2.6 01/04] scsi: make scsi_send_eh_cmnd use
	its own timer instead of scmd->eh_timeout
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <426C2FC3.4090105@gmail.com>
References: <20050419143100.E231523D@htj.dyndns.org>
	 <20050419143100.0F9A8C3B@htj.dyndns.org>
	 <1114381342.4786.17.camel@mulgrave>  <426C2FC3.4090105@gmail.com>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 11:09:04 -0700
Message-Id: <1114452544.5000.11.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-25 at 08:46 +0900, Tejun Heo wrote:
>   If you're talking about scmd->eh_timeout, it's our main timer for 
> normal command timeouts.  If you're suggesting renaming it to something 
> more apparant, I agree.  Maybe just scmd->timeout will do.

Sorry ... actually on the ball now; I was assuming you simply wanted not
to use the field for efficiency.  

So, actually having read the description, you think that reusing the
eh_timeout in the error handler command submission path could confuse
the normal done routine if the host still has the command pending and
completes it?

Jmaes


