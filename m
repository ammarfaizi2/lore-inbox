Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbUALOMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265532AbUALOMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:12:42 -0500
Received: from mail2.ugr.es ([150.214.35.29]:26792 "EHLO mail2.ugr.es")
	by vger.kernel.org with ESMTP id S265526AbUALOMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:12:39 -0500
Message-ID: <4002AB67.3010005@ugr.es>
Date: Mon, 12 Jan 2004 15:12:55 +0100
From: Ruben Garcia <ruben@ugr.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, ja, en, es-es
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: loop device changes the block size and causes misaligned
 accesses to the real device, which can't be processed
References: <3FFC3BF4.6080105@ugr.es> <20040108040414.GA5017@fukurou.paranoiacs.org> <3FFD34D5.1080605@ugr.es>
In-Reply-To: <3FFD34D5.1080605@ugr.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruben Garcia wrote:
> Ok, Ben's patch will make the loop device work as any other device, and 
> then ext2 will complain that the hard blocksize is bigger than the 
> blocksize used for ext2 (in my example of 1k for ext2) and fail to mount 
> it.
> 
> This is better than getting misaligned transfers et all, and is 
> consistent with using the real device.
> 
> On the other hand, it is much more useful being able to actually mount 
> the ext2 fs, and I managed to do that with the loop-aes patch (Thanks 
> Jari Ruusu)
> 
> I confirm this bug closed. Thanks to all
>

I tried Ben's patch and it does work for encrypted CDs (i.e. you can 
mount them) I'm going to try a non encrypted CD now to see what I find.

