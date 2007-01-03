Return-Path: <linux-kernel-owner+w=401wt.eu-S1750830AbXACPFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbXACPFY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbXACPFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:05:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:54129 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbXACPFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:05:24 -0500
In-Reply-To: <20070103141807.GA8236@in.ibm.com>
References: <20070103041645.GA17546@in.ibm.com> <20070103135326.GF20714@stusta.de> <20070103141807.GA8236@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3cbf78b7065f2e1822c9e9f4c193a788@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: Adrian Bunk <bunk@stusta.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Jean Delvare <khali@linux-fr.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] i386 kernel instant reboot with older binutils fix
Date: Wed, 3 Jan 2007 16:02:27 +0100
To: vgoyal@in.ibm.com
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hopefully this patch should solve steve's issue too.

Sure looks like it.

> o Older binutils required explicit flags to mark a section allocatable
>   and executable(AX). Newer binutils automatically mark a section AX if
>   the name starts with .text.

More exactly, since 2.15 more section names are automatically
recognised as being of a certain type; older binutils already
did this for plain .text, for example.  Just a nitpick, but
perhaps it explains the problem better; I'm fine with the
patch as-is.


Segher

