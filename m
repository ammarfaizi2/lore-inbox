Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131777AbRAKNNL>; Thu, 11 Jan 2001 08:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130339AbRAKNNB>; Thu, 11 Jan 2001 08:13:01 -0500
Received: from pat.uio.no ([129.240.130.16]:39835 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S130006AbRAKNMs>;
	Thu, 11 Jan 2001 08:12:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14941.45349.131276.684932@charged.uio.no>
Date: Thu, 11 Jan 2001 14:12:05 +0100 (CET)
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <20010111125604.A17177@redhat.com>
In-Reply-To: <E14GQyR-0000mh-00@the-village.bc.nu>
	<Pine.LNX.4.10.10101101210080.4572-100000@penguin.transmeta.com>
	<20010111125604.A17177@redhat.com>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephen C Tweedie <sct@redhat.com> writes:

     > Hi, On Wed, Jan 10, 2001 at 12:11:16PM -0800, Linus Torvalds
     > wrote:
    >>
    >> That said, we can easily support the notion of CLONE_CRED if we
    >> absolutely have to (and sane people just shouldn't use it), so
    >> if somebody wants to work on this for 2.5.x...

     > But is it really worth the pain?  I'd hate to have to audit the
     > entire VFS to make sure that it works if another thread changes
     > our credentials in the middle of a syscall, so we either end up
     > having to lock the credentials over every VFS syscall, or take
     > a copy of the credentials and pass it through every VFS
     > internal call that we make.

 What's wrong with copy-on-write style semantics? IOW, anyone who
wants to change the credentials needs to make a private copy of the
existing structure first.

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
