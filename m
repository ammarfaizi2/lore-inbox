Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVG2DP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVG2DP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVG2DN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:13:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15488 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262322AbVG2DLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:11:47 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	<20050727104123.7938477a.akpm@osdl.org>
	<m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
	<20050727224711.GA6671@elf.ucw.cz>
	<Pine.LNX.4.58.0507271550250.3227@g5.osdl.org>
	<20050727225334.GC6529@elf.ucw.cz>
	<m1oe8n7s4v.fsf@ebiederm.dsl.xmission.com>
	<20050728074344.GH6529@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 28 Jul 2005 21:11:26 -0600
In-Reply-To: <20050728074344.GH6529@elf.ucw.cz> (Pavel Machek's message of
 "Thu, 28 Jul 2005 09:43:44 +0200")
Message-ID: <m1hdee5msh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:


> I always thought that device_shutdown is different phase -- the one
> with interrupts disabled...

At the end of device_shutdown interrupts are disabled because we
shutdown the interrupt controllers.  

I don't think we have a phase where the interrupts are disabled,
except for the code that runs after device_shutdown, and the bootup
code that happens before interrupts are enabled.

Eric
