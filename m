Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVBVTnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVBVTnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVBVTkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:40:14 -0500
Received: from hermes.domdv.de ([193.102.202.1]:25874 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261453AbVBVTja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:39:30 -0500
Message-ID: <421B8A69.8000903@domdv.de>
Date: Tue, 22 Feb 2005 20:39:21 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pcg@goof.com
CC: Alex Adriaanse <alex.adriaanse@gmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Odd data corruption problem with LVM/ReiserFS
References: <93ca3067050220212518d94666@mail.gmail.com> <4219C811.5070906@domdv.de> <20050222190149.GB9590@schmorp.de>
In-Reply-To: <20050222190149.GB9590@schmorp.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pcg( Marc)@goof(A.).(Lehmann )com wrote:
> I use both reiserfs and ext3 on lvm/dm on raid.
> 
> Both filesystems have issues when restoring from backup (i.e. very heavy
> write activity).
> 
> I did report this to the linux kernel, and got as reply that there are
> indeed races *somewhere*, but as of yet there is no fix.
> 
> The symptoms are _not_ I/O errors (but until I see logs I wouldn't believe
> you that there are real I/O errors), but usually too-high block numbers.
> 

To clarify: there were no disk I/O errors, only I/O errors were reported 
  by find during operation so it is definitely filesystem corruption 
that is  going on here.
Though find performs heavy read activity there could well be heavy write 
activity be involved due to atime updates so this fits your description.

> A reboot fixes this for both ext3 and reiserfs (i.e. the error is gone).
> 

Well, it didn't fix it for me. The fs was trashed for good. The major 
question for me is now usability of md/dm for any purpose with 2.6.x. 
For me this is a showstopper for any kind of 2.6 production use.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
