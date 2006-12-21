Return-Path: <linux-kernel-owner+w=401wt.eu-S964781AbWLUOWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWLUOWj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbWLUOWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:22:39 -0500
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:3219 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753210AbWLUOWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:22:38 -0500
Date: Thu, 21 Dec 2006 15:22:39 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-Id: <20061221152239.6af2d443.khali@linux-fr.org>
In-Reply-To: <20061221034029.GD30299@in.ibm.com>
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
	<m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
	<m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
	<20061221101240.f7e8f107.khali@linux-fr.org>
	<20061221102232.5a10bece.khali@linux-fr.org>
	<m164c5pmim.fsf@ebiederm.dsl.xmission.com>
	<20061221145401.07bfe408.khali@linux-fr.org>
	<20061221034029.GD30299@in.ibm.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 09:10:29 +0530, Vivek Goyal wrote:
> Ok. so indirect jump seems to be having problem. On my machine disassembly
> of setup.o show following.
> 
> ff a6 14 02 00 00       jmp    *0x214(%esi)
> 
> This seems to be fine as 0x14 is the offset of code32_start, and 
> ((DELTA_INITSEG) << 4) is 0x200. How does it look like on your machine?

    1110:	ff a6 14 02 00 00    	jmp    *0x214(%esi)

So exactly the same.

-- 
Jean Delvare
