Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUEWP4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUEWP4s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUEWP4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:56:48 -0400
Received: from zasran.com ([198.144.206.234]:35968 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S263101AbUEWP4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:56:44 -0400
Message-ID: <40B0C9BB.4020304@bigfoot.com>
Date: Sun, 23 May 2004 08:56:43 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and /dev/sda1 not found during boot (it's there right after
 boot)
References: <408A1945.1030506@bigfoot.com> <20040424155507.GA11273@kroah.com>
In-Reply-To: <20040424155507.GA11273@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Apr 24, 2004 at 12:37:41AM -0700, Erik Steffl wrote:
> 
>>  just moved to udev and everything seems to be working OK except of 
>>SATA drive (visible as /dev/sda1) when fsck checks it during boot (it 
>>works fine right after that).
> 
> 
> This is a Debian specific bug/issue.  I suggest you file it against the
> Debian udev package, as it is not a kernel issue.

   why would you think it's debian specific issue?

   btw if I add sleep at the beginning of /etc/init.d/checkfs.sh (runs 
fsck for all filesystems) everythings works. Which I guess confirms that 
there is some delay between when the module is loaded and when the 
device is available in userspace. Is that how udev works? How can this 
issue be solved?

   kernel 2.6.5, udev 0.024, debian unstable

	erik
