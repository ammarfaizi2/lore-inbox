Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTLVGdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 01:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTLVGdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 01:33:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:33930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264387AbTLVGdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 01:33:42 -0500
Date: Sun, 21 Dec 2003 22:33:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Slusky <sluskyb@paranoiacs.org>
Cc: linux-kernel@vger.kernel.org, jariruusu@users.sourceforge.net
Subject: Re: [PATCH] loop.c patches, take two
Message-Id: <20031221223332.5c625592.akpm@osdl.org>
In-Reply-To: <20031221195534.GA4721@fukurou.paranoiacs.org>
References: <20031030134137.GD12147@fukurou.paranoiacs.org>
	<3FA15506.B9B76A5D@users.sourceforge.net>
	<20031030133000.6a04febf.akpm@osdl.org>
	<20031031005246.GE12147@fukurou.paranoiacs.org>
	<20031031015500.44a94f88.akpm@osdl.org>
	<20031101002650.GA7397@fukurou.paranoiacs.org>
	<20031102204624.GA5740@fukurou.paranoiacs.org>
	<20031221195534.GA4721@fukurou.paranoiacs.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Slusky <sluskyb@paranoiacs.org> wrote:
>
> Well, it appears that neither my loop.c patches nor Andrew's were merged
>  into 2.6.0... I'd request that my patches be merged into mainline,
>  since Jari Ruusu has pointed out that Andrew's patch (which removes the
>  separate code path for block-backed loop devices) will break journaling
>  filesystems on loop devices. Right now, journaling FS's on file-backed
>  loop devices are kinda iffy (they will work only if the underlying FS is
>  also journaled, with the correct journal options) but journaling FS's
>  on block-backed loop devices work perfectly. Andrew's patches would
>  break this.

I'm not sure how important this is?

Remember that one of the reasons for dropping the block-backed special case
was that it ran like crap under heavy load.  It locked up, iirc.  Has that
been fixed here?

