Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUAHXm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266379AbUAHXm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:42:27 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:29112 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S266376AbUAHXm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:42:26 -0500
Message-ID: <3FFDEAE6.4030503@metaparadigm.com>
Date: Fri, 09 Jan 2004 07:42:30 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Kent <raven@themaw.net>, Mike Waychison <Michael.Waychison@Sun.COM>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net> <3FFD9498.6030905@zytor.com>
In-Reply-To: <3FFD9498.6030905@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/04 01:34, H. Peter Anvin wrote:
> In many ways this returns to the simplicity of the autofs v3 design 
> where the atomicity constraints where guaranteed by the VFS itself, *as 
> long as* mount traps can be atomically destroyed with umounting the 
> underlying filesystem.

Do we need to revive Tigran's forced unmount patch 'badfs' ala FreeBSD's
deadfs? Although it doesn't guarantee atomic unmount, it could help
a lot with the tendancy to get stuck autofs mounts.

   http://tinyurl.com/2hto8

I've been long waiting for this functionality in mainline.

I wonder if binding badfs over the mountpoint at the beginning of the
potentially lengthy unmount process would improve the atomicity
to userspace. ie although the unmount would proceed in the background,
badfs would have been mounted at that point at the start of the process
- mounts are atomic no?

~mc

