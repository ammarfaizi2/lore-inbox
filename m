Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbTHZHdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 03:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTHZHdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 03:33:32 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:24582 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262663AbTHZHdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 03:33:31 -0400
Date: Tue, 26 Aug 2003 08:32:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Samphan Raruenrom <samphan@nectec.or.th>
Cc: Jens Axboe <axboe@image.dk>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
Message-ID: <20030826083249.B20776@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Samphan Raruenrom <samphan@nectec.or.th>,
	Jens Axboe <axboe@image.dk>, linux-kernel@vger.kernel.org,
	Linux TLE Team <rdi1@opentle.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org> <3F4B0343.7050605@nectec.or.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F4B0343.7050605@nectec.or.th>; from samphan@nectec.or.th on Tue, Aug 26, 2003 at 01:50:43PM +0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 01:50:43PM +0700, Samphan Raruenrom wrote:
> I'm sorry for issueing this layering violation. I read a guideline that
> it's easier to submit a patch to add device driver ioctl than inventing
> something new. It really doesn't belong here.

That guideline is wrong.  Adding a driver ioctl is slmost always wrong.

> Could you guide me where else can I place this functionality?
> 
> (my random idea)
> - fcntl(open("/dev/cdrom", F_MNTSTAT)
> - umount2("/dev/cdrom", MS_TEST) // not actually perform
> - new system call! e.g. mntstat(open("/dev/cdrom"))

In userspace.  Or you could tell me what you want to actually
archive - your call by itself doesn't make any sense.

