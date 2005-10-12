Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbVJLUbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbVJLUbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 16:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbVJLUbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 16:31:55 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:65512 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751540AbVJLUby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 16:31:54 -0400
Date: Wed, 12 Oct 2005 22:31:52 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Jeff Mahoney <jeffm@suse.com>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <Pine.LNX.4.64.0510122114140.9696@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.62.0510122221250.13771@artax.karlin.mff.cuni.cz>
References: <20051010204517.GA30867@br.ibm.com> 
 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> 
 <20051010214605.GA11427@br.ibm.com>  <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
  <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> 
 <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
 <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com>
 <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com>
 <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.64.0510122114140.9696@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> But discarding data sometimes on USB unplug is even worse than discarding data
>> always --- users will by experimenting learn that linux doesn't discard
>> write-cached data and reminds them to replug the device --- and one day,
>> randomly, they lose their data because of some memory management condition...
>
> And how exactly is that worse than discarding the data every time?!?!?!?

Undeterministic behaviour is worse than deterministic. You can learn 
the system that behaves deterministically.

If you know that unplug damages filesystem on your USB disk, you replug 
it, recheck filesystem and copy the important data again --- you have 0% 
probability of data damage.
However, if damage on unplug happens only with 1/100 probability, will 
you still check filesystem and copy all recently created files on it? You 
forget it (or you wouldn't even know that damage might occur) and you have 
1% probability of data damage.

Mikulas

> Best regards,
>
> 	Anton
