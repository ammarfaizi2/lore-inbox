Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVHIHyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVHIHyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVHIHyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:54:18 -0400
Received: from burnt-tech.com ([66.98.218.53]:31451 "HELO burntmail.com")
	by vger.kernel.org with SMTP id S932462AbVHIHyS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:54:18 -0400
From: "vinay" <vinays@burntmail.com>
To: linux-kernel@vger.kernel.org
Cc: vinays@burntmail.com
Importance: Normal
Sensitivity: Normal
Message-ID: <W74008295030461123574049@burntmail>
X-Mailer: Mintersoft VisualMail, Build 4.0.111601
X-Originating-IP: [203.200.200.70]
Date: Tue, 09 Aug 2005 07:54:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I have a problem with linux kernel's Out Of Memory (OOM) killer.
I wanted to know, is there any way that we can force OOM killer to send a signal other than SIGKILL to kill a process when ever OOM detects a system memory crunch. 
Actually I have an application that is getting killed by OOM killer when the 
system runs out of memory. It seems like OOM killer is sending SIGKILL to the 
process. As SIGKILL cannot be caught by a process, my application is exiting 
without doing proper cleanup. 
    Is there any way that we can force OOM killer to send a signal other than
SIGKILL ? So that my application can call the signal handler and do proper cleanup before exiting. 

I searched through Google and came acorss some solution -
Like setting the capability of a process to CAP_SYS_RAWIO will force the OOM killer to send SIGTERM. I tried to set the capability of my application to CAP_SYS_RAWIO using capset() system call, but still then OOM killer is sending SIGKILL. 

Could anybody please help me out with this problem ?
Any pointers are welcomed.

Thanks in advance.

Vinay.


