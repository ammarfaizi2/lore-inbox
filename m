Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265028AbTFCO3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbTFCO3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:29:43 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:1175 "EHLO
	thumper2.emsphone.com") by vger.kernel.org with ESMTP
	id S265028AbTFCO3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:29:41 -0400
Date: Tue, 3 Jun 2003 09:42:58 -0500
From: Andrew Ryan <genanr@emsphone.com>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS io errors on transfer from system running 2.4 to system running 2.5
Message-ID: <20030603144257.GA31734@thumper2.emsphone.com>
References: <200306031912.53569.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306031912.53569.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 07:12:51PM +0800, Michael Frank wrote:
> Speaking of weird errors:
> 
> For the last few months I encounter this:
> 
> When doing rsync or cp _from_ system running 2.4 _to_ system running 2.5 
> get Input/output error errors with random files.
> 
> - Encountered since 2.4.20 with about 2.5.64 (my first 2.5 kernel)
> 
I am having a similar problem writing to NFS mounted non-linux system on
kernels past 2.4.20-pre3.  I get an input/output error while writing.  I
have sent email to Trond Myklebust (who made the changes between pre3 and
pre4).  And he said to switch to using the TCP protocol for mounts.  That
worked, but I should not have to do that because

1. It worked to 2.4.20pre3 without a problem
2. Other OSes such as FreeBSD do not have issues writing to other OSes using
UDP soft mounts.

To me, there is something wrong with the changes that went in in 2.4.20pre4,
it should work as it does in pre3 and/or other unix OSes such as FreeBSD. 
We should not have to work around the problem with hard links or using TCP
instead of UDP.

Andy 
