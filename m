Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbTFRTxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265406AbTFRTxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:53:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:55525 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265379AbTFRTxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:53:22 -0400
Subject: Re: [PATCH] Support non reserved ports for NFS client
To: trond.myklebust@fys.uio.no
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF90A826B7.444525BC-ON88256D49.006D66FE-88256D49.006E8344@us.ibm.com>
From: Bruce Allan <bruce.allan@us.ibm.com>
Date: Wed, 18 Jun 2003 13:07:05 -0700
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.0.1 [IBM]|June 10, 2003) at
 06/18/2003 14:07:08
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





May I make the suggestion that instead of creating a new flag (i.e.
NFS_MOUNT_NONRESERVED) and using a new bit in the flags field of struct
nfs_mount_data, Andi use the already existing and unused NFS_MOUNT_SECURE
assuming that is what was originally intended for this bit.  This would
also match in name with the secure/insecure export option on the server.

Regards,
---
Bruce Allan  <bruce.allan@us.ibm.com>
Software Engineer, Linux Technology Center
IBM Corporation, Beaverton OR
503-578-4187   IBM Tie-line 775-4187



                                                                                                                          
                      Trond Myklebust                                                                                     
                      <trond.myklebust@fys.ui        To:       Andi Kleen <ak@suse.de>                                    
                      o.no>                          cc:       linux-kernel@vger.kernel.org                               
                      Sent by:                       Subject:  [PATCH] Support non reserved ports for NFS client          
                      linux-kernel-owner@vger                                                                             
                      .kernel.org                                                                                         
                                                                                                                          
                                                                                                                          
                      06/18/2003 11:32 AM                                                                                 
                      Please respond to                                                                                   
                      trond.myklebust                                                                                     
                                                                                                                          
                                                                                                                          




>>>>> " " == Andi Kleen <ak@suse.de> writes:

     > Currently you cannot have more than 1024 mounts for a single
     > local IP address because the NFS client always tries to get a
     > "secure" port <1024.

     > This patch adds a new noreserved mount option to disable this.

Hi Andi,

  I've already got a patch to accomplish most of this in

  http://www.fys.uio.no/~trondmy/src/2.4.21
/linux-2.4.21-11-fix_tcprace3.dif

It's a backport of some patches that have already gone into 2.5.x to
fix some TCP client reconnection issues. I was hoping to push these
patches to Marcelo for 2.4.22.

Could you therefore please just send me a patch for the
NFS_MOUNT_NONRESERVED mount option alone. Then I'll append it to this
patch series?

This should also make it easy to port the whole thing forward to 2.5.x
(although please note that for 2.5.x I'm also planning some other
improvements that will allow us to share the struct xprt between
different RPC clients).

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



