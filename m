Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTDMISf (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 04:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTDMISf (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 04:18:35 -0400
Received: from nmail1.systems.pipex.net ([62.241.160.130]:56233 "EHLO
	nmail1.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263357AbTDMISe (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 04:18:34 -0400
To: Robert Love <rml@tech9.net>
Subject: Re: Re: Processor sets (pset) for linux kernel 2.5/2.6?
Message-ID: <1050222609.3e992011e4f54@netmail.pipex.net>
Date: Sun, 13 Apr 2003 09:30:09 +0100
From: "Shaheed R. Haque" <srhaque@iee.org>
Cc: <linux-kernel@vger.kernel.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net>  <1050177383.3e986f67b7f68@netmail.pipex.net> <1050177751.2291.468.camel@localhost>
In-Reply-To: <1050177751.2291.468.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: PIPEX NetMail 2.2.0-pre13
X-PIPEX-username: aozw65%dsl.pipex.com
X-Originating-IP: 81.86.202.62
X-Usage: Use of PIPEX NetMail is subject to the PIPEX Terms and Conditions of use
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Robert Love <rml@tech9.net>:

> We strive for simple interfaces here in Linux :)
> 
> If you want to give them exclusive access, you need to bind all the
> other processes to the other processors.  One easy way to do this is to
> have init bind itself elsewhere on boot.

Interesting idea. AFAICS, this involves either changing the code of /sbin/init 
to set its affinity to a default cpu mask (provided by a kernel boot flag, I 
presume), or using taskset-like functionality and then hoping that all current 
shells etc. die before the programs I care about start.

Would it not be better to simply have the kernel use the boot flag directly as 
the default CPU mask setting?

[ I can see the argument that "if you need such control, you should set up your 
distro to deal with it", but that is a level of tweaking I would like to avoid 
for my customers ]

Thanks, Shaheed


