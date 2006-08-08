Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWHHOj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWHHOj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWHHOj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:39:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:58126 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964929AbWHHOj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:39:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Rq2uun7GSS5EcEpXCR2EnktZDVD2mrvN9sbcpiFq+8MQg/vzYQqzJo1npRGXGPwiC+zFKjadFImnZJHqpc7kJyoj3LEWeIL8RlFEfqqgeKI3HA1hevIeeSDryNsvyjIE54f44kwX/ws1CK9lTTyORd74oyhWsGaq3Otg5Rs0Q9Y=
Message-ID: <9a8748490608080739w2e14e5ceg44a7bf0a3b475704@mail.gmail.com>
Date: Tue, 8 Aug 2006 16:39:54 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock manager!
Cc: "Trond Myklebust" <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some webservers that have recently started reporting the
following message in their logs :

  do_vfs_lock: VFS is out of sync with lock manager!

The serveres kernels were upgraded to 2.6.17.8 and since the upgrade
the message started appearing.
The servers were previously running 2.6.13.4 without experiencing this problem.
Nothing has changed except the kernel.

I've googled a bit and found this mail
(http://lkml.org/lkml/2005/8/23/254) from Trond saying that
"The above is a lockd error that states that the VFS is failing to track
your NFS locks correctly".
Ok, but that doesn't really help me resolve the issue. The servers are
indeed running NFS and access their apache DocumentRoots from a NFS
mount.

Is there anything I can do to help track down this issue?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
