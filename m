Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269848AbUH0BEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269848AbUH0BEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269844AbUH0BAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:00:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23175 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269848AbUH0Axc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:53:32 -0400
Message-ID: <412E85FD.5050801@pobox.com>
Date: Thu, 26 Aug 2004 20:53:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       steved@redhat.com, dwmw2@redhat.com
Subject: Re: [PATCH] CacheFS - general filesystem cache
References: <17777.1093566183@redhat.com>
In-Reply-To: <17777.1093566183@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Hi Linus, Andrew,
> 
> I've packaged my generic filesystem cache filesystem into patches and also
> produced patches for my AFS filesystem to use it. Work is also in progress to
> alter the NFS client use this interface too, and I think the ISO9660
> filesystem could also benefit.

<and the audience goes wild>  whee :)

IMHO cachefs is a big deal particularly now that the NFSv4 delegation 
code has been merged.

For those unfamiliar with the changes from NFSv3 -> NFSv4, one of the 
many nice features of v4 is that it has sane caching.  A file can be 
"delegated" to the client, such that, the client has complete control 
over the file including caching.  Sorta like a lease.  Great for 
cachefs, IOW.  :)


>     (7) cachefs-afs-2681mm4.diff
> 
> 	This changes my AFS client so that it can make use of cachefs.

Yay, a user :)

	Jeff


