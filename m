Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314351AbSEFNo7>; Mon, 6 May 2002 09:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314362AbSEFNo6>; Mon, 6 May 2002 09:44:58 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:39241 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314351AbSEFNo5>;
	Mon, 6 May 2002 09:44:57 -0400
Date: Mon, 6 May 2002 15:43:45 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: aia21@cantab.net, wstinsonfr@yahoo.fr, linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.5.13 severe file system corruption experienced follozing e2fsck ...
Message-Id: <20020506154345.39f12ad5.sebastian.droege@gmx.de>
In-Reply-To: <20020506085033.GD820@suse.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002 10:50:33 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Mon, May 06 2002, Anton Altaparmakov wrote:
> > At 06:55 06/05/02, Jens Axboe wrote:
> > >On Sun, May 05 2002, Anton Altaparmakov wrote:
> > >> Note even with that fix IDE (at least TCQ) is really easy to crash when 
> > >you
> > >> put the system under heavier I/O (at least on my via box)...
> > >
> > >If you have stumpled upon a tcq bug, I'd like to know more about it.
> > 
> > Back trace (sorry didn't have ckermit running so didn't catch the whole 
> > output and was too lazy to write it all down): blk_queue_invalidate_tags, 
> > tcq_invalidate_queue, ide_dmaq_complete, ide_dmaq_intr, ata_irq_request, 
> > ide_dmaq_intr, handle_IRQ_event, do_IRQ, ideprobe_init.
> 
> Same problem as Sebastian I'm sure, in which case the backtrace holds no
> info for me, the IDE messages printed _before_ the panic would be
> helpful though :-)
Ok here they are (or do you mean the ide initialisation?):

[normal stuff]

ide_tcq_intr_timeout: timeout waiting for service interrupt...
ide_tcq_intr_timeout: hwgroup not busy
hda: invalidating pending queue (10)
kernel BUG at ll_rw_blk.c:407!

[panic]
