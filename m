Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281442AbRKFDEu>; Mon, 5 Nov 2001 22:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281440AbRKFDEm>; Mon, 5 Nov 2001 22:04:42 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:18419
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277722AbRKFDE2>; Mon, 5 Nov 2001 22:04:28 -0500
Date: Mon, 5 Nov 2001 19:04:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: David Chow <davidchow@rcn.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dirty Page cache in 2.4
Message-ID: <20011105190417.A665@mikef-linux.matchmail.com>
Mail-Followup-To: David Chow <davidchow@rcn.com.hk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BE7513D.40403@rcn.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE7513D.40403@rcn.com.hk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 10:55:57AM +0800, David Chow wrote:
> Dear all,
> 
> I've heard the memory management in 2.4 swap out dirty pages. Is it true 
> that dirty pages refer to the dirty pages of page cache and they may 
> also be swapped out? Thanks.
> 

No, very untrue.

To be more specific, there are dirty filesystem cache pages, and dirty
application pages.  Dirty filesystem pages will be written to the FS, while
dirty application pages will be swapped out.  

If an application page is chosen for swap out and it is not dirty, the VM
will just discard that page completely because it can beloaded from the app
or library on disk when needed again...

BTW, both VMs would do this.  This behavior is very fundamental to VM design.

Mike
