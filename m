Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318844AbSH1OMq>; Wed, 28 Aug 2002 10:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318848AbSH1OMk>; Wed, 28 Aug 2002 10:12:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26358 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318844AbSH1OMi>; Wed, 28 Aug 2002 10:12:38 -0400
Subject: Re: Writing files to remote storage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Liao <kevinliao@iei.com.tw>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <00cf01c24e6b$678127e0$1d0d11ac@ieileb9wqxg5qq>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
	<20020828081412.GA1496@spunk> 
	<00cf01c24e6b$678127e0$1d0d11ac@ieileb9wqxg5qq>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 28 Aug 2002 15:18:42 +0100
Message-Id: <1030544322.7290.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-28 at 09:17, Kevin Liao wrote:
> If I mount a remote linux partition through smb or nfs and write one file to
> that partition. How could I make sure that that file is really written to
> the remote disk successfully? I know that some cache mechanisms existed in
> linux kernel. So I guess there may be two possibilities as below:

For NFS at least do an fsync(). Fsync should ensure the data hits the
server. Whether the server commits to stable storage is protocol and
configuration dependant (NFS says yes, some implementations fudge it)
 

