Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbSKOSMq>; Fri, 15 Nov 2002 13:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266631AbSKOSMq>; Fri, 15 Nov 2002 13:12:46 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:9419 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S266622AbSKOSMp>;
	Fri, 15 Nov 2002 13:12:45 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Fri, 15 Nov 2002 19:19:06 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: NFS mountned  directory  and apache2 (2.5.47)
Cc: linux-kernel@vger.kernel.org, richard@bouska.cz
X-mailer: Pegasus Mail v3.50
Message-ID: <79A23782BB8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 02 at 19:10, Trond Myklebust wrote:

>      > Hello In 2.45.47 and 2.5.46 (at least) did not try any other am
>      > I not able to serve files bigger than 255 bytes by apache2 from
>      > nfs mounted directory. The local files are served correctly.
> 
> Looks like whoever it was that changed the 'sendfile' API forgot to
> update NFS. Try the following patch.

It does not change anything on the brokeness of apache2 (or maybe
glibc). It must be able to revert to read/write loop if sendfile fails
with EINVAL. There is no guarantee that existing sendfile() API means
that you can use it with all filesystems.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
