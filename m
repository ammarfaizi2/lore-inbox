Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVEDVdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVEDVdr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVEDVdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:33:47 -0400
Received: from hera.kernel.org ([209.128.68.125]:20372 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261665AbVEDVdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:33:40 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Hanged/Hunged process in Linux
Date: Wed, 4 May 2005 09:09:53 -0700
Organization: Open Source Development Lab
Message-ID: <20050504090953.20b57374@dxpl.pdx.osdl.net>
References: <1115185128.12535.233322099@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1115222993 14750 10.8.0.74 (4 May 2005 16:09:53 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 4 May 2005 16:09:53 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 May 2005 14:38:48 +0900
"Deepak" <deepakgaur@fastmail.fm> wrote:

> I am working on a Linux based system and developing a monitoring process
> which shall do the following function
> 
> (1) It will detect abnormally terminated application process and will
> restart the process group
> 
> (2) It will detect a hanged application and will restart it
> 
> My query is regarding second point . What should be the proper
> definition of a "Hanged Process" in Linux context . I searched on google
> regarding it and got the following definitions
> 
> (1) A process not accepting any signals and consuming system resources
> (2) A process in STOP state
> (3) A process in deadlock state
> 
> Process conforming to definition 3 will be due to race conditions/bad
> programming.Definition 1 does define a proper hanged process but is it
> possible to create such a process in LInux as in linux signal delivery
> to the process and its handling is assured by the Linux kernel.
> 
> Anybody having another definition for a "Hanged process" in Linux
> context
> 
> Deepak Gaur

It is impossible to absolutely tell the difference between a very busy process and one
that is hung.  Better to build to build hang detection into the process itself with
a heartbeat interface. Look at the hangcheck timer, nmi_watchdog, and watchdog
devices.
-- 
Stephen Hemminger	<shemminger@osdl.org>
