Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272094AbRHVTEi>; Wed, 22 Aug 2001 15:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272086AbRHVTET>; Wed, 22 Aug 2001 15:04:19 -0400
Received: from trained-monkey.org ([209.217.122.11]:17423 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S272092AbRHVTEH>; Wed, 22 Aug 2001 15:04:07 -0400
To: Adam Radford <aradford@3WARE.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: [patch] 3Ware 64 bit locking issues
In-Reply-To: <53B208BD9A7FD311881A009027B6BBFB9EAE47@siamese>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 22 Aug 2001 15:04:14 -0400
In-Reply-To: Adam Radford's message of "Wed, 22 Aug 2001 11:48:07 -0700"
Message-ID: <m3g0ajncgh.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adam" == Adam Radford <aradford@3WARE.com> writes:

Adam> Thanks for flags type fix and redundant pushf/popf fix.
Adam> Regarding your question about the error handling routines, the
Adam> 3ware driver uses the new style scsi error handling, so looking
Adam> through scsi_error.c, all calls to
Adam> hostt->eh_abort_handler() and hostt->eh_host_reset_handler() are
Adam> wrapped with a spin_lock_irqsave(&io_request_lock, flags) and
Adam> spin_unlock_irqrestore(&io_request_lock, flags) so they should
Adam> be okay.

Hmm ok. However, since Jens is working on killing the io_request_lock
so something will need to get done when that happens.

Jens, what is the strategy for that?

Cheers
Jes
