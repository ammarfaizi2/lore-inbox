Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTHZJ4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 05:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbTHZJ4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 05:56:17 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15627 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263561AbTHZJ4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 05:56:15 -0400
Date: Tue, 26 Aug 2003 10:56:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Samphan Raruenrom <samphan@nectec.or.th>
Cc: Jens Axboe <axboe@image.dk>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
Message-ID: <20030826105613.A23356@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Samphan Raruenrom <samphan@nectec.or.th>,
	Jens Axboe <axboe@image.dk>, linux-kernel@vger.kernel.org,
	Linux TLE Team <rdi1@opentle.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org> <3F4B0343.7050605@nectec.or.th> <20030826083249.B20776@infradead.org> <3F4B23E2.8040401@nectec.or.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F4B23E2.8040401@nectec.or.th>; from samphan@nectec.or.th on Tue, Aug 26, 2003 at 04:09:54PM +0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 04:09:54PM +0700, Samphan Raruenrom wrote:
> The only visible feature of this new magicdev is that now
> GNOME users can eject there CDs (the discs' icon will
> disappear). The eject button now act as 'umount' command.
> 
> One new requirement from this new magicdev is the question
> "will umount failed?". I have no preference on any way to
> implement it. Should there be the right way to do it, I'll
> do so. I can think of many way to implement it (including
> adding a new lazy-lock mode to cdrom device) but since
> I have no kernel hacking experience, I need everyone
> advices. Novice users need this 'eject' button after all.

This doesn't make sense at all.  Just try the unmount and
tell the user if it failed - you can't say whether it will
fail before trying.

