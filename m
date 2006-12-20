Return-Path: <linux-kernel-owner+w=401wt.eu-S932707AbWLTAJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbWLTAJ0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWLTAJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:09:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47665 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932674AbWLTAJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:09:24 -0500
Date: Tue, 19 Dec 2006 16:08:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: ltuikov@yahoo.com
Cc: Jurriaan <thunder7@xs4all.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Jeff Garzik <jeff@garzik.org>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>, Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
Message-Id: <20061219160840.bb6b155f.akpm@osdl.org>
In-Reply-To: <362582.18476.qm@web31811.mail.mud.yahoo.com>
References: <20061217160056.GA3555@amd64.of.nowhere>
	<362582.18476.qm@web31811.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 15:26:00 -0800 (PST)
Luben Tuikov <ltuikov@yahoo.com> wrote:

> The reason was that my dev tree was tainted by this bug:
> 
>         if (good_bytes &&
> -           scsi_end_request(cmd, 1, good_bytes, !!result) == NULL)
> +           scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
>                 return;
> 
> in scsi_io_completion().  I had there !!result which is wrong, and when
> I diffed against master, it produced a bad patch.

Oh.  I thought that got sorted out.  It's a shame this wasn't made clear to
me..

> As James mentioned one of the chunks is good and can go in.

Please send a new patch, not referential to any previous patch or email,
including full changelogging.

