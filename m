Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266662AbRGJQsp>; Tue, 10 Jul 2001 12:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266661AbRGJQsf>; Tue, 10 Jul 2001 12:48:35 -0400
Received: from ECE.CMU.EDU ([128.2.236.200]:12694 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S266654AbRGJQsZ>;
	Tue, 10 Jul 2001 12:48:25 -0400
Date: Tue, 10 Jul 2001 12:48:20 -0400 (EDT)
From: Craig Soules <soules@happyplace.pdl.cmu.edu>
To: Andi Kleen <ak@suse.de>
cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <20010710154135.A4603@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.3.96L.1010710124338.16113W-100000@happyplace.pdl.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Andi Kleen wrote:
> Because to get that new cookie you would need another cookie; otherwise
> you could violate the readdir guarantee that it'll never return files
> twice.

I cannot locate any such guarantee in the NFS spec... are you refering to
another spec which applies?

> BTW; the cookie issue is not an NFS only problem. It occurs on local
> IO as well. Just consider rm -rf - reading directories and in parallel
> deleting them (the original poster's file system would have surely
> gotten that wrong). Another tricky case is telldir().  

I don't believe that the behavior in this case is deterministic.  If you
have multiple people accessing a single file, reading and writing to it,
there is no guarantee as to what the behavior is.  The client should be
able to handle any errors it creates for itself while doing this kind of
parallel operation.

Craig

