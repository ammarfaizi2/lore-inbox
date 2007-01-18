Return-Path: <linux-kernel-owner+w=401wt.eu-S932100AbXARJRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbXARJRg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 04:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbXARJRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 04:17:36 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:57786 "EHLO
	agminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbXARJRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 04:17:35 -0500
Date: Thu, 18 Jan 2007 17:10:34 +0800
From: Joe Jin <joe.jin@oracle.com>
To: gareth@valinux.com, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Why not set siginfo at do_general_protection()?
Message-ID: <20070118091034.GA5826@joejin-pc.cn.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question, while a general protection occured, do_general_protection()
should be called, to other faults, it always set siginfo struct, but at this  
function, it just send a SIGSEGV by force_sig() call but not create a siginfo
struct, at send_signal(), it check the siginfo's value and create the siginfo,
then set siginfo->si_code to SI_KERNEL, but to SIGSEGV signal, the si_code 
should be SEGV_MAPERR or SEGV_ACCERR, to application, it will receive a 
siginfo which si_code is SI_KERNEL, so, why not check the details of fault, 
and set the corresponding value?

Would you pls give me any advices?

Thanks,
Joe
