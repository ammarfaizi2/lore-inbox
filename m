Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264349AbTICXdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbTICXdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:33:41 -0400
Received: from pat.uio.no ([129.240.130.16]:32213 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264331AbTICXdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:33:36 -0400
To: Pascal Schmidt <der.eremit@email.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: [NFS] attempt to use V1 mount protocol on V3 server
References: <Pine.LNX.4.44.0309040004230.4629-100000@neptune.local>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 03 Sep 2003 19:33:31 -0400
In-Reply-To: <Pine.LNX.4.44.0309040004230.4629-100000@neptune.local>
Message-ID: <shsptihla5w.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Pascal Schmidt <der.eremit@email.de> writes:

     > a) when unmounting an NFS volume, the server gets sent an umount
     >    request indicating version 1 of the protocol, sending a
     >    version 3 umount is not even attempted

     > b) when something goes wrong during the NFSv3 mount, the kernel
     >    seems to fall back to NFSv2, re-attempting the mount with
     >    mount protocol version 1

     > I think both of this should not be done when the remote side
     > does not advertise mount protocol version 1 support.

     > Question: is this a problem of the user-space mount utility or
     > is it an in-kernel problem?


  a) Is a feature of the 'mount' program. An NFS server should in any
     case not rely on the umount being sent: a client may have crashed
     or been firewalled, or whatever...

  b) Is a kernel feature which will never trigger if you are passing a
     correct filehandle from your mountd.

Cheers,
  Trond
