Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130878AbRAKNLL>; Thu, 11 Jan 2001 08:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131201AbRAKNLB>; Thu, 11 Jan 2001 08:11:01 -0500
Received: from Cantor.suse.de ([194.112.123.193]:23559 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130878AbRAKNKy>;
	Thu, 11 Jan 2001 08:10:54 -0500
Date: Thu, 11 Jan 2001 14:10:38 +0100
From: Andi Kleen <ak@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010111141038.A26189@gruyere.muc.suse.de>
In-Reply-To: <E14GQyR-0000mh-00@the-village.bc.nu> <Pine.LNX.4.10.10101101210080.4572-100000@penguin.transmeta.com> <20010111125604.A17177@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010111125604.A17177@redhat.com>; from sct@redhat.com on Thu, Jan 11, 2001 at 12:56:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 12:56:04PM +0000, Stephen C. Tweedie wrote:
> Hi,
> 
> On Wed, Jan 10, 2001 at 12:11:16PM -0800, Linus Torvalds wrote:
> > 
> > That said, we can easily support the notion of CLONE_CRED if we absolutely
> > have to (and sane people just shouldn't use it), so if somebody wants to
> > work on this for 2.5.x...
> 
> But is it really worth the pain?  I'd hate to have to audit the entire
> VFS to make sure that it works if another thread changes our
> credentials in the middle of a syscall, so we either end up having to
> lock the credentials over every VFS syscall, or take a copy of the
> credentials and pass it through every VFS internal call that we make.

That is what NFS does already, it would just move into generic VFS then.
(NFS copies) 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
