Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTJWSNJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 14:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTJWSNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 14:13:09 -0400
Received: from walker.svs.informatik.uni-oldenburg.de ([134.106.22.19]:48516
	"EHLO walker.pmhahn.de") by vger.kernel.org with ESMTP
	id S261484AbTJWSNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 14:13:07 -0400
Date: Thu, 23 Oct 2003 20:12:52 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre8
Message-ID: <20031023181251.GA5490@titan.lahn.de>
Mail-Followup-To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Trond, LKML.

On Wed, Oct 22, 2003 at 09:24:17PM -0200, Marcelo Tosatti wrote:
> Trond Myklebust:
>   o Fix a deadlock in the NFS asynchronous write code
>   o A request cannot be used as part of the RTO estimation if it gets
>     resent since you don't know whether the server is replying to the 
>     first or the second transmission. However we're currently setting the 
>     cutoff point to be the timeout of the first transmission.
>   o UDP round trip timer fix. Modify Karn's algorithm so that we inherit timeouts from previous requests.
>   o Increase the minimum RTO timer value to 1/10 second. This is more in line with what is done for TCP.
>   o Fix a stack overflow problem that was noticed by Jeff Garzik by removing some unused readdirplus cruft.
>   o Make the client act correctly if the RPC server's asserts that it does not support a given program, version or procedure call.

make[3]: Entering directory `/usr/src/linux-2.4.23/net/sunrpc'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -fno-optimize-sibling-calls -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=clnt  -c -o clnt.o clnt.c
clnt.c: In function `call_verify':
clnt.c:946: error: duplicate case value
clnt.c:926: error: previously used here
clnt.c:951: error: duplicate case value
clnt.c:937: error: previously used here

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
