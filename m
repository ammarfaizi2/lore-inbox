Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWCLKkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWCLKkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWCLKkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:40:08 -0500
Received: from cantor2.suse.de ([195.135.220.15]:18662 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932074AbWCLKkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:40:06 -0500
Date: Sun, 12 Mar 2006 11:40:04 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: enable NAP only on cpus who support it to avoid memory corruption
Message-ID: <20060312104004.GA26091@suse.de>
References: <20060311215840.GA22766@suse.de> <1142121302.4057.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1142121302.4057.52.camel@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Mar 12, Benjamin Herrenschmidt wrote:

> On Sat, 2006-03-11 at 22:58 +0100, Olaf Hering wrote:
> > commit 51d3082fe6e55aecfa17113dbe98077c749f724c enabled NAP unconditinally
> > on all powermacs. Early G3 cpus can not use it, the result is memory corruption.
> 
> Ok, here is what I think is a proper fix: Just remove the code from
> setup.c since feature.c will already set powersave_nap when needed.
> 
> Can you test asap please ? If it fixes the problem for you, I'll send
> the patch to Linus/Andrew with hopes that it will make it in 2.6.16 

Yes, this helps.
