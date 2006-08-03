Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWHCCUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWHCCUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 22:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWHCCUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 22:20:37 -0400
Received: from hu-out-0102.google.com ([72.14.214.193]:57394 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751357AbWHCCUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 22:20:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OnOxUx4yXcZ8usw1CQ4oZYVv6VbBq3yDCfY8m7FxpRCki3rp6lU0UgGj1SrMUSIxCvR+2uh2mCYrLyqx2Qspjcg1BP3+xmpjs8m11GIvQ8gx8RD0HMOx9C0EQk119BdPDPmdunMSrdnVxWudp05FB+3tLi6uXqccJ/p5r6A0C3c=
Message-ID: <7a329d910608021920h6c1bb625q5336115cfd253adf@mail.gmail.com>
Date: Wed, 2 Aug 2006 19:20:25 -0700
From: "Wil Reichert" <wil.reichert@gmail.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Subject: Re: Solaris ZFS on Linux
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Ian Stirling" <ian.stirling@mauve.plus.com>,
       "David Masover" <ninja@slaphack.com>,
       "David Lang" <dlang@digitalinsight.com>,
       "Nate Diller" <nate.diller@gmail.com>,
       "Adrian Ulrich" <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       lkml@lpbproductions.com, "Jeff Garzik" <jeff@garzik.org>,
       "Theodore Ts'o" <tytso@mit.edu>,
       "LKML Kernel" <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
In-Reply-To: <m3ejvzqkjf.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>
	 <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>
	 <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>
	 <20060801010215.GA24946@merlin.emma.line.org>
	 <44CEAEF4.9070100@slaphack.com>
	 <Pine.LNX.4.63.0607312114500.15179@qynat.qvtvafvgr.pbz>
	 <44CED95C.10709@slaphack.com> <44CFE8D9.9090606@mauve.plus.com>
	 <0DA0B214-50BC-4E20-A520-B7AB121BB38B@mac.com>
	 <m3ejvzqkjf.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/06, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Kyle Moffett <mrmacman_g4@mac.com> writes:
>
> > IMHO the best alternative for a situation like that is a storage
> > controller with a battery-backed cache and a hunk of flash NVRAM for
> > when the power shuts off (just in case you run out of battery), as
> > well as a separate 1GB battery-backed PCI ramdisk for an external
> > journal device (likewise equipped with flash NVRAM).  It doesn't take
> > much power at all to write a gig of stuff to a small flash chip
> > (Think about your digital camera which runs off a couple AA's), so
> > with a fair-sized on-board battery pack you could easily transfer its
> > data to NVRAM and still have power left to back up data in RAM for 12
> > hours or so.  That way bootup is fast (no reading 1GB of data from
> > NVRAM) but there's no risk of data loss.
>
> Not sure - reading flash is fast, but writing is quite slow.
> A digital camera can consume a set of 2 or 4 2500 mAh AA cells
> for a fraction of 1 GB (of course, only a part of power goes
> to flash).

Seeks are fast, throughput is terrible, power is minimal:

http://techreport.com/reviews/2006q3/supertalent-flashide/index.x?pg=1

Wil
