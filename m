Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVGGRwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVGGRwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVGGRtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:49:42 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:60830 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261402AbVGGRt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:49:26 -0400
To: Jens Axboe <axboe@suse.de>
Cc: "'Clemens Koller'" <clemens.koller@anagramm.de>,
       "'Lenz Grimmer'" <lenz@grimmer.com>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Jesper Juhl'" <jesper.juhl@gmail.com>,
       "'Dave Hansen'" <dave@sr71.net>, hdaps-devel@lists.sourceforge.net,
       "'LKML List'" <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
In-Reply-To: <20050707173412.GL24401@suse.de>
References: <42CD600C.2000105@anagramm.de> <002401c58317$865ee6a0$600cc60a@amer.sykes.com> <002401c58317$865ee6a0$600cc60a@amer.sykes.com> <20050707173412.GL24401@suse.de>
Date: Thu, 7 Jul 2005 18:49:07 +0100
Message-Id: <E1DqaUl-0003qg-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:

> What is needed is to flesh out what the kernel interface should looke
> like. I suggested a sysfs file for suspending and resuming access to the
> device, if people have other ideas they should voice them.

That sounds quite reasonable. Does it need to do anything other than
park the head and suspend the command queue for that device?

(On an only slightly related note, for full ACPI support of PATA, we're
supposed to use the _GTF interface. This returns a set of taskfile
commands that are then supposed to be executed by the host. However, at
the point where we want to do this, the IDE queues haven't been
restarted. Is the best solution here just to add a trivial and stupid
IDE driver for managing the disks when we don't want userspace doing
anything with them?)

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
