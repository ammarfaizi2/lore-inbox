Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVIMQgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVIMQgH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVIMQgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:36:06 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:42707 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964868AbVIMQgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:36:04 -0400
Subject: Re: [2.6.14-rc1] sym scsi boot hang
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Anton Blanchard <anton@samba.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050913142939.GE26162@krispykreme>
References: <20050913124804.GA5008@in.ibm.com>
	 <20050913131739.GD26162@krispykreme>  <20050913142939.GE26162@krispykreme>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 11:35:44 -0500
Message-Id: <1126629345.4809.36.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 00:29 +1000, Anton Blanchard wrote:
> I just noticed a similar hang on the ibmvscsi driver. The following
> backout patch seems to fix it (part of the scsi merge yesterday), I'll
> look closer after I get some sleep.

If that's the cause, it's probably a double down of the host scan
semaphore somewhere in the code.  alt-sysrq-t should work in this case,
can you get a stack trace of the blocked process?

Thanks,

James


