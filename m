Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVFCJXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVFCJXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 05:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVFCJXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 05:23:09 -0400
Received: from tms.rz.uni-kiel.de ([134.245.11.89]:32457 "EHLO
	tms.rz.uni-kiel.de") by vger.kernel.org with ESMTP id S261193AbVFCJXB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 05:23:01 -0400
Subject: Re: TPM on IBM thinkcenter S51
From: Torsten Landschoff <tla@comsys.informatik.uni-kiel.de>
To: trusted linux <tcimpl2005@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050602220028.3572.qmail@web61014.mail.yahoo.com>
References: <20050602220028.3572.qmail@web61014.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 11:23:08 +0200
Message-Id: <1117790588.6249.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 15:00 -0700, trusted linux wrote:
> thanks, here is my strace related to tpm:
> 
> open("/dev/tpm", O_RDWR)                = -1 ENODEV
> (No such device)
> write(2, "Can\'t open TPM Driver\n", 22Can't open TPM
> Driver
> ) = 22

Okay, so the driver is in fact not working. It could be that /dev/tpm
has the wrong device number assigned. If the driver is really installed
can be checked by

	systool -c misc|grep tpm

I bet it does not show anything. OTOH if the module loads successfully
it really should be there. No idea what's going wrong then. 

Which version of the driver are you using?

Greetings

	Torsten

