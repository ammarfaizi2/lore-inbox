Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTHZODS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTHZOBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:01:14 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:8466 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263831AbTHZN63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 09:58:29 -0400
Date: Tue, 26 Aug 2003 14:58:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Samphan Raruenrom <samphan@nectec.or.th>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Jens Axboe <axboe@image.dk>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Rdi1] Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
Message-ID: <20030826145821.A26398@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Samphan Raruenrom <samphan@nectec.or.th>,
	Jens Axboe <axboe@suse.de>, Jens Axboe <axboe@image.dk>,
	linux-kernel@vger.kernel.org, Linux TLE Team <rdi1@opentle.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org> <3F4B0343.7050605@nectec.or.th> <20030826083249.B20776@infradead.org> <3F4B23E2.8040401@nectec.or.th> <20030826105613.A23356@infradead.org> <20030826095830.GA20693@suse.de> <3F4B44C2.4030406@nectec.or.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F4B44C2.4030406@nectec.or.th>; from samphan@nectec.or.th on Tue, Aug 26, 2003 at 06:30:10PM +0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 06:30:10PM +0700, Samphan Raruenrom wrote:
> >>This doesn't make sense at all.  Just try the unmount and
> >>tell the user if it failed - you can't say whether it will
> >>fail before trying.
> 
> Yes, you can! Reading the code, if vfsmount.mnt_count > 1 then
> umount on that device will fail.

if you are doing the unmount currently and nothing changes because
you hold the nessecary locks, yes.  But as soon as you drop the locks
this is void.  There's no way to find out whether you can unmount
a filesystem except trying it.

> Hmm. You seem to advice me to detect the 'eject' button then issue
> a umount? I don't know how and I guess it is impossible. But maybe
> I'm wrong.

See Jens' post.

