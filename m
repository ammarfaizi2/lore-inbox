Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTGBSxA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTGBSxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:53:00 -0400
Received: from vaxjo.synopsys.com ([198.182.60.75]:34760 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S264398AbTGBSwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:52:55 -0400
Message-ID: <3F032D60.2060002@Synopsys.COM>
Date: Wed, 02 Jul 2003 21:07:12 +0200
From: Harald Dunkel <harri@synopsys.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: lapeyre@physics.arizona.edu, greg@kroah.com
Subject: Re: [PATCH] USB updates for 2.4.21
References: <20030702182249.GA11236@bacchus.optics.arizona.edu>
In-Reply-To: <20030702182249.GA11236@bacchus.optics.arizona.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Lapeyre wrote:
> Re: From: Greg KH (greg@kroah.com)
>     Date: Thu Jun 19 2003 - 19:40:35 EST 
> 
> Broken ehci-hcd things seem to be fixed with this patch. I had
> numerous crashes, hangs, filesystem corruption, etc. with
>  2.4.19,20,21 until I applied this. I am using,
> 
>  DVD burner in an external USB 2.0  enclosure (same as the one rebranded by Belkin)
>  IDE drive in the same model enclosure.
>  Epson 3200 scanner.
> 
>  Using them before the patch, particularly simultaneously, caused driver crashes. They
>  seem to share the bus nicely now.
> 

The failure rate on accessing an IDE disk via USB 2.0 has been
decreased dramatically with this patch, but I still get IO
errors pretty frequently.

But the real bad part is: If there is an IO error, then I cannot
sync _any_ of my mounted partitions anymore (all SCSI). A 'sync'
gets stuck. All I can do is a power cycle.

Would it be possible to decouple the mounted partitions somehow?
I don't care for the disk with IO error, but a sync should not
get stuck for a valid partition not showing any problems.


Regards

Harri

