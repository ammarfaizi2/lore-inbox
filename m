Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTIMLBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 07:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTIMLBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 07:01:35 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:49379 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262114AbTIMLBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 07:01:34 -0400
Date: Sat, 13 Sep 2003 13:01:32 +0200 (MEST)
Message-Id: <200309131101.h8DB1WNd021570@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: axboe@suse.de
Subject: DMA for ide-scsi?
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Sep 2003 08:29:18 +0200, Jens Axboe <axboe@suse.de> wrote:
>> Actually with 2.6, you no longer need ide-scsi.  You'll need to upgrade 
>> your cdrecord tools and probably your burning GUI, if you use one.  I've 
>> been burning that way for several months now.  (I'm using xcdroast, 
>> though I need to start it with "-n" since I'm using cdrecord 2.01a18.)  
>> This actually works better for me than ide-scsi as for some reason it 
>> uses less CPU.
>
>That's because it _is_ faster. It contains no silly memory allocations
>for the buffer and data copying in the kernel, the data is mapped from
>the user buffer and DMA'ed directly from there. It also uses DMA where
>ide-scsi wont.

That begs the question: why won't ide-scsi do DMA?
I understand you'd rather see it disappear (:->) but since I use
it for other ATAPI devices as well, I'd like to see it maintained
and fully operational. Having DMA in ide-scsi would be nice.

(And the concept of using a SCSI API to ATA devices is in itself
not broken, even if the implementation has some problems.)

/Mikael
