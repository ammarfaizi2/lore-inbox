Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbTDWTBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264237AbTDWTBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:01:49 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:12750 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S264233AbTDWTBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:01:47 -0400
Message-Id: <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 23 Apr 2003 12:13:37 -0700
To: linux-kernel@vger.kernel.org
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK ChangeSet@1.1118.1.1] new module infrastructure for
  net_proto_family
Cc: davem@redhat.com, acme@conectiva.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

Can somebody (DaveM perhaps) please explain to me what the hell the following 
changset is doing in 2.5.68 
        http://linux.bkbits.net:8080/linux-2.5/cset@1.1118.1.1?nav=index.html|ChangeSet@-7d
??

I've spent quite a bit of time looking into what's needed to fix socket module refcounting
issues and convicting DaveM and Alex that we need to fix them.
Here is the original thread
        http://marc.theaimsgroup.com/?l=linux-kernel&m=104308300808557&w=2

My patch was rejected without giving any technical explanation. I was waiting for Rusty's
__module_get() patch to get in, to release a new patch which addresses some issues that
came up during discussion.
Next thing you know, incomplete patch (changeset mentioned above) shows up in the BK and
2.5.68. Without even a simple note on the lkm. And completely ignoring discussion that 
we had about this very issue just a few weeks ago.

I don't mind of course if some other (better) patch is accepted instead of mine. But patch 
that went in is incomplete and buggy. It doesn't handle accept case properly and doesn't 
address the issue of the 'struct sock' ownership (read original thread for more details).

Thanks

Max

http://bluez.sf.net
http://vtun.sf.net

