Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269900AbTGMPlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 11:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269912AbTGMPlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 11:41:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36781 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269900AbTGMPlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 11:41:15 -0400
Message-ID: <3F118105.8000200@pobox.com>
Date: Sun, 13 Jul 2003 11:55:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
References: <20030711140219.GB16433@suse.de> <20030712152406.GA9521@mail.jlokier.co.uk> <3F103018.6020008@pobox.com> <20030712112722.55f80b60.akpm@osdl.org> <20030712183929.GA10450@mail.jlokier.co.uk> <3F105B9A.7070803@pobox.com> <20030712193401.GD10450@mail.jlokier.co.uk> <3F1063AD.40206@pobox.com> <20030712194624.GF10450@mail.jlokier.co.uk> <20030713085118.V4482@schatzie.adilger.int>
In-Reply-To: <20030713085118.V4482@schatzie.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Jul 12, 2003  20:46 +0100, Jamie Lokier wrote:
> 
>>Jeff Garzik wrote:
>>
>>>Jamie Lokier wrote:
>>>
>>>>2.4 fails on write()?  A strace of "rpm --rebuilddb" shows it is
>>>>opening with O_DIRECT and writing just fine.  Or does that only work
>>>>with RedHat's 2.4 kernels?
>>>
>>>Are you testing on a filesystem where an O_DIRECT is not supported?
>>>The "it works" case is not an issue.
>>
>>ext3.
> 
> 
> ext3 in 2.4 kernels does not support O_DIRECT.  To confuse matters,
> recent RH kernels silently ignore O_DIRECT if you are not root, so
> you may think O_DIRECT is being used, but it isn't.


ahhh, that's probably what is going on.  I was thinking only of stock 
2.4 behavior (open succeeds, write fails).

	Jeff



