Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311959AbSCVKeS>; Fri, 22 Mar 2002 05:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311961AbSCVKeI>; Fri, 22 Mar 2002 05:34:08 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:28402 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S311959AbSCVKdy>; Fri, 22 Mar 2002 05:33:54 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <shsu1rci4zr.fsf@charged.uio.no> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@ton.iguana.be (Ton Hospel), linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Mar 2002 10:33:39 +0000
Message-ID: <24969.1016793219@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


trond.myklebust@fys.uio.no said:
>  As for re-exporting: that can be done pretty easily too unless of
> course you actually expect it to be reliable. The tough cookie is to
> get it to survive server reboots.

The problem here is that we're using the anonymous device which the NFS 
mount happens to have as sb->s_dev as the device ID in our exported file 
handles. We don't have to do that; we could use something slightly more 
useful, based on the root fh we got from the _real_ server, surely?
 

--
dwmw2


