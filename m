Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVEMPwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVEMPwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVEMPwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:52:17 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:64732 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262413AbVEMPvv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:51:51 -0400
In-Reply-To: <4284CBB5.6060609@fujitsu-siemens.com>
Subject: Re: Again: UML on s390 (31Bit)
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org, Ulrich Weigand <uweigand@de.ibm.com>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF004E24A7.29043C55-ONC1257000.0056CCB5-C1257000.00570853@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 13 May 2005 17:50:37 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 13/05/2005 17:51:46
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Each time when the kernel is entered again and a signal is pending,
> do_signal() will be called on return to user with regs->trap setup
> freshly. So, I still believe the patch doesn't have *any* effect.

Oh, the patch does have an effect for the debugger. If the debugger
stopped on the sys_sig_return system call and does e.g. an inferior
function call, then the kernel might want to restart a system call
that isn't there because the debugger did a "jump" but could not
change regs->trap.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


