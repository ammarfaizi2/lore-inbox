Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265109AbUF1SO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbUF1SO4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUF1SOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:14:55 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:2217 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S265109AbUF1SOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:14:44 -0400
Date: Mon, 28 Jun 2004 12:18:35 -0600
From: "Eric D. Mudama" <edmudama@bounceswoosh.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, Ed Tomlinson <edt@aei.ca>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040628181835.GA14632@bounceswoosh.org>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	"Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
	Jens Axboe <axboe@suse.de>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Jeff Garzik <jgarzik@pobox.com>, Ed Tomlinson <edt@aei.ca>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040610164135.GA2230@bounceswoosh.org> <Pine.LNX.4.10.10406260118220.19080-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10406260118220.19080-100000@master.linux-ide.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26 at  1:31, Andre Hedrick wrote:
>
>Eric,
>
>There is no need for a new opcode.
>The behavior is simple and trivial to support.
>
>If standard flush_cache/ext were to behave just like standard data_in
>taskfile register setup, yet use a non_data command state machine it would
>be done.
>
>Special case would be deal with LBA Zero and this would have to behave
>like a complete device flush.  Since flushing sector zero is not generally
>done ... well this would go into a design debate and it is not my issue
>nor my desire to enter one today.
>
>28-bit would support max 256 sectors
>48-bit would support max 65536 sectors
>
>Anyone could write this simple proposal to T13 for SATA and T10 for SAS.

True, that would work just as well.

But as you mention, it isn't necessarilly what people want or think
they want or could actually use...

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

