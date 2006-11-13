Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753726AbWKMAsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbWKMAsf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 19:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbWKMAsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 19:48:35 -0500
Received: from koto.vergenet.net ([210.128.90.7]:17795 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1753725AbWKMAse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 19:48:34 -0500
Date: Mon, 13 Nov 2006 09:23:03 +0900
From: Horms <horms@verge.net.au>
To: David Miller <davem@davemloft.net>
Cc: jeremy@goop.org, magnus.damm@gmail.com, ebiederm@xmission.com,
       magnus@valinux.co.jp, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com,
       ak@muc.de, fastboot@lists.osdl.org, anderson@redhat.com
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
Message-ID: <20061113002301.GB3296@verge.net.au>
References: <45550D2F.2070004@goop.org> <20061110.153930.23011358.davem@davemloft.net> <455518C6.8000905@goop.org> <20061110.164349.35665774.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110.164349.35665774.davem@davemloft.net>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 04:43:49PM -0800, David Miller wrote:
> From: Jeremy Fitzhardinge <jeremy@goop.org>
> Date: Fri, 10 Nov 2006 16:26:46 -0800
> 
> > David Miller wrote:
> > > I think Elf64 notes very much would need 64-bit alignment, especially
> > > if there are u64 objects in there.  Otherwise it would not be possible
> > > to directly dereference such objects without taking unaligned faults
> > > on several types of RISC cpus.
> > >   
> > 
> > That doesn't appear to have been a problem.
> 
> We should be OK with the elf note header since n_namesz, n_descsz, and
> n_type are 32-bit types even on Elf64.  But for the contents embedded
> in the note, I am not convinced that there are no potential issues.

The interesting thing is that from my reading of the elf64 spec,
name ends up being 32 bit alightned, and desc ends up being 64 bit
aligned. Do you think the former could be a problem? I am thinking not
as its always a string.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

