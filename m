Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUJIUfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUJIUfK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUJIUeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:34:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:26512 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267380AbUJIU2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:28:06 -0400
Date: Sat, 9 Oct 2004 22:28:03 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Olaf Hering <olh@suse.de>
Subject: Re: out of order execution of shell commands
Message-ID: <20041009202803.GA6298@suse.de>
References: <20041007204653.GA26820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041007204653.GA26820@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Oct 07, Olaf Hering wrote:

> 
> we have a weird bug where the open of the shell output redirection
> happens before the mkdir command returns.
> As a result, the redirection will fail. Unexpected data loss.

...
>         for l in `/bin/cat ten`; do
>           /bin/mkdir $h$i/$j/$k/$l
>           /bin/echo $h$i/$j/$k/$l > ./$h$i/$j/$k/$l/DIRNAME || /bin/kill -STOP `/bin/cat /dev/shm/bug42232-pid-*`
>           /bin/dd if=/dev/zero of=$h$i/$j/$k/$l/data bs=1024 count=1 &> /dev/zero
>         done
...

looks like the dd and the mkdir will get the same pid,
and bash can not deal with it.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
