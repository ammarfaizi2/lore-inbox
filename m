Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSFTKfn>; Thu, 20 Jun 2002 06:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSFTKfm>; Thu, 20 Jun 2002 06:35:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11472 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313492AbSFTKfm>;
	Thu, 20 Jun 2002 06:35:42 -0400
Date: Thu, 20 Jun 2002 12:35:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE booting problems with 2.5.23
Message-ID: <20020620103532.GA812@suse.de>
References: <16471.1024566396@warthog.cambridge.redhat.com> <3D11A6BB.8030705@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D11A6BB.8030705@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20 2002, Martin Dalecki wrote:
> BTW> Jens did you notice that the IDE_DMA flag is a "read only"
> flag? I see basically only TQC code checking it. I would
> like to replace the drive->waiting_for_dma flag field by the
> proper usage of the IDE_DMA bit. Any way this could bite TCQ code?
> The checks there appear to be only sanity checks anyway.

At first I did just add them as sanity checks, but later on I had the
same thought myself (get rid of drive->waiting_for_dma). So go ahead
with that.

BTW, I see you renamed the flags to channel->active. I think that's a
bit misleading, can't you just call it ->state or ->flags (or
->state_flags? :-)

-- 
Jens Axboe

