Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274284AbRITHiZ>; Thu, 20 Sep 2001 03:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274353AbRITHiO>; Thu, 20 Sep 2001 03:38:14 -0400
Received: from ns.caldera.de ([212.34.180.1]:9929 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S274284AbRITHiG>;
	Thu, 20 Sep 2001 03:38:06 -0400
Date: Thu, 20 Sep 2001 09:38:10 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: GOTO Masanori <gotom@debian.or.jp>
Cc: rfuller@nsisoftware.com, linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010920093810.A19534@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	GOTO Masanori <gotom@debian.or.jp>, rfuller@nsisoftware.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com> <200109192226.f8JMQ5112543@ns.caldera.de> <w53r8t2h7pz.wl@megaela.fe.dis.titech.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <w53r8t2h7pz.wl@megaela.fe.dis.titech.ac.jp>; from gotom@debian.or.jp on Thu, Sep 20, 2001 at 12:16:56PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 12:16:56PM +0900, GOTO Masanori wrote:
> At Thu, 20 Sep 2001 00:26:05 +0200,
> Christoph Hellwig <hch@ns.caldera.de> wrote:
> > > "One argument for reverse mappings is distributed shared memory or
> > > distributed file systems and their interaction with memory mapped files.
> > > For example, a distributed file system may need to invalidate a specific
> > > page of a file that may be mapped multiple times on a node."
> > 
> > Please take a look at zap_inode_mappings in -ac.
> 
> zap_inode_mapping ?

Yes.

> 
> > Currently it only invalidates a whole mapping, but we can easily add
> > offset and lenght (and will probably do).
> 
> Adding offset/length support is good. 
> Did you mean that replacing zap_inode_mapping into more parts like
> zap_inode_mapping_whole and zap_inode_mapping_range ?

That depends.  For 2.4 at least we (the OpenGFS Project) probably won't
need it - and I didn't hear from other groups that need such functionality
yet.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
