Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbTCHVob>; Sat, 8 Mar 2003 16:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbTCHVob>; Sat, 8 Mar 2003 16:44:31 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:59405 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262243AbTCHVoa>; Sat, 8 Mar 2003 16:44:30 -0500
Date: Sat, 8 Mar 2003 21:55:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308215506.A881@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl> <20030308073407.A24272@infradead.org> <20030308192908.GB26374@kroah.com> <20030308194331.A31291@infradead.org> <b4dn6d$go8$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b4dn6d$go8$1@cesium.transmeta.com>; from hpa@zytor.com on Sat, Mar 08, 2003 at 01:26:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 01:26:37PM -0800, H. Peter Anvin wrote:
> We need it if anything even more for character devices.  Character
> devices are under even more allocation pressure, and just look at the
> ugly hacks we've already had to play for e.g. tty devices.

Yes.  That's why the work applied to block devices already needs to
be done to character device too and as a side-effect we get an
almost 32bit dev_t clean tree, too.

