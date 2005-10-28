Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbVJ1Lzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVJ1Lzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 07:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbVJ1Lzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 07:55:40 -0400
Received: from [213.8.54.133] ([213.8.54.133]:19591 "EHLO fw.netmor.com")
	by vger.kernel.org with ESMTP id S965216AbVJ1Lzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 07:55:40 -0400
Message-ID: <436211B0.1050509@weizmann.ac.il>
Date: Fri, 28 Oct 2005 13:55:28 +0200
From: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en, ru, he
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
References: <4360C0A7.4050708@weizmann.ac.il> <200510271609.47309.rob@landley.net>
In-Reply-To: <200510271609.47309.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> But no, this one's clearly a kernel error.  If the kernel is giving write 
> errors against the device afterwards, than the kernel's internal state 
> toggled successfully, which is all the mount syscall was trying to do.  Mount 
> is just reporting whether or not the syscall succeeded, not whether or not it 
> should have. :)

OK, so there are actually two separate bugs, it seems: one that 
remounting a RO media in the RW mode succeeds (this "works" for any RO 
media, as far as I can tell) and the second (this one is specific to the 
floppy driver only) that a further write to such a falsely rw-remounted 
media doesn't return (in the user space) an error.

Regards,

Evgeny
