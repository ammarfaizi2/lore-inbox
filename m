Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUHAEHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUHAEHx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 00:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbUHAEHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 00:07:53 -0400
Received: from main.gmane.org ([80.91.224.249]:22151 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265154AbUHAEHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 00:07:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: ide-cd problems
Date: Sun, 01 Aug 2004 10:07:57 +0600
Message-ID: <cehqak$1pq$1@sea.gmane.org>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de> <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <20040731210257.GA22560@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsa.physics.usu.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <20040731210257.GA22560@bliss>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zinx Verituse wrote:
> I don't believe command filtering is neccessary, since all of the
> ide-cd ioctls are still there (ioctls that allow playing, reading, etc)
> Only the SG_IO ioctl itself would have to be checked (i.e., not each
> individual command available with SG_IO, just the overall ioctl itself,
> categorizing all of SG_IO more or less as raw IO.  If this isn't doable
> with the current design, then the ide-cd interface should at least be
> very conspicuously documented as being extremely insecure as far as
> "read" access is concerned, as I know I wouldn't expect users to be able
> to overwrite my drive's firmware simply by granting the read access.
> 

Remember that it is still possible to write CDs through ide-cd in 2.4.x 
using some pre-alpha code in cdrecord:

cdrecord dev=ATAPI:1,1,0 image.iso

-- 
Alexander E. Patrakov

