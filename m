Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTIMRL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTIMRL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:11:28 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:11419 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261814AbTIMRL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:11:27 -0400
Subject: Re: [lkml] RE: self piping and context switching
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Iker <iker@computer.org>
Cc: David Schwartz <davids@webmaster.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <03f501c379a2$b14b49b0$3203a8c0@duke>
References: <MDEHLPKNGKAHNMBLJOLKCECHGIAA.davids@webmaster.com>
	 <03f501c379a2$b14b49b0$3203a8c0@duke>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063473005.8519.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sat, 13 Sep 2003 18:10:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 03:56, Iker wrote:
> More specifically, I was wondering if the write to the pipe or the call back
> into poll involved anything that might prompt the scheduler to replace the
> thread in this scenario.

Unless it happens to cause page faults or fill up the pipe nothing in
paticular.  Sending a message to yourself down a pipe is pretty standard
in event based programs as a way of turning a signal from asynchronous
event and thus nuisance to handle into a message.

