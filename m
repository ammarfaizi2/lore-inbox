Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSGaLyu>; Wed, 31 Jul 2002 07:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSGaLyt>; Wed, 31 Jul 2002 07:54:49 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53728 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317950AbSGaLys>; Wed, 31 Jul 2002 07:54:48 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200207311158.g6VBwAa29820@devserv.devel.redhat.com>
Subject: Re: manipulating sigmask from filesystems and drivers
To: dhowells@redhat.com (David Howells)
Date: Wed, 31 Jul 2002 07:58:10 -0400 (EDT)
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
In-Reply-To: <15189.1028116363@warthog.cambridge.redhat.com> from "David Howells" at Jul 31, 2002 12:52:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OpenAFS filesystem driver, and it tries to achieve uninterruptible I/O waiting
> by the following means:

Bletch

> The reason for them doing this is so that they can get the process to appear
> in the "S" state and thus avoid increasing the load average.

Thats come up enough I wish there was a way to distinguish 'disk wait'
and uninterruptible. Its an old V7 handwaving load average estimation trick
that lived too long IMHO

> Can you comment on whether a driver is allowed to block signals like this, and
> whether they should be waiting in TASK_UNINTERRUPTIBLE?

NFS does something similar in hard mount mode. 
