Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280383AbRKEIvJ>; Mon, 5 Nov 2001 03:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280384AbRKEIu7>; Mon, 5 Nov 2001 03:50:59 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22772
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280383AbRKEIuv>; Mon, 5 Nov 2001 03:50:51 -0500
Date: Mon, 5 Nov 2001 00:50:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: disk throughput
Message-ID: <20011105005035.A18620@mikef-linux.matchmail.com>
Mail-Followup-To: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au> <20011105094701.H29577@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011105094701.H29577@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 09:47:01AM +0100, Jan Kara wrote:
> If I understood well the code it tries to spread files uniformly over the
> fs (ie. all groups equally full). I think that if you have filesystem like
> /home where are large+small files changing a lot your change can actually
> lead to more fragmentation - groups in the beginning gets full (files
> are created in the same group as it's parent). Then if some file gets deleted
> and new one created filesystem will try to stuff new file in the first
> groups and that causes fragmentation.. But it's just an idea - some testing
> would be probably more useful...
> 

Shouldn't it choose another block group if the file won't fit in the current
one?
