Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbQKQQwS>; Fri, 17 Nov 2000 11:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQKQQwJ>; Fri, 17 Nov 2000 11:52:09 -0500
Received: from Cantor.suse.de ([194.112.123.193]:39945 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130038AbQKQQvy>;
	Fri, 17 Nov 2000 11:51:54 -0500
Date: Fri, 17 Nov 2000 17:21:47 +0100
From: Andi Kleen <ak@suse.de>
To: Doug Alcorn <doug@lathi.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FAQ followup: changes in open fd/proc in 2.4.x?
Message-ID: <20001117172147.A10855@gruyere.muc.suse.de>
In-Reply-To: <m38zqitwtn.fsf@balder.seapine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m38zqitwtn.fsf@balder.seapine.com>; from doug@lathi.net on Fri, Nov 17, 2000 at 10:58:12AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 10:58:12AM -0500, Doug Alcorn wrote:
> With the 2.2.x kernel, our choices are basically to live with the
> limitation or redesign.  We certainly don't like the limitation and
> are talking about a redesign.

Later 2.2.x (x>=11 or so) has no limitations on fds/procs, other than what you set 
with ulimit and the global limit (/proc/sys/fs/{file,inode}-max) 
2.2.x before that need to be recompiled for more than 1024 fds/proc and they
will also waste a lot of memory for high settings.

Some older library functions may cause problems though when they use select() 
and you pass a fd>=1024 to them. 

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
