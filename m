Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbRDKMIZ>; Wed, 11 Apr 2001 08:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRDKMIP>; Wed, 11 Apr 2001 08:08:15 -0400
Received: from mons.uio.no ([129.240.130.14]:53945 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S132558AbRDKMIF>;
	Wed, 11 Apr 2001 08:08:05 -0400
To: Jussi Hamalainen <count@theblah.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: lockd trouble
In-Reply-To: <Pine.LNX.4.33.0104102258040.3166-100000@mir.senv.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Apr 2001 14:07:56 +0200
In-Reply-To: Jussi Hamalainen's message of "Tue, 10 Apr 2001 23:01:41 +0300 (EEST)"
Message-ID: <shsofu3fxlv.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jussi Hamalainen <count@theblah.org> writes:

     > I do have a question about lockd. How do I get it back if I
     > need to restart portmap? Running rpc.lockd doesn't seem to have
     > any effect whatsoever on the listed rpc services and I can't
     > just reload the module since nfs depends on it.

You can use pmap_dump/pmap_set to save/restore the
state. Alternatively umount all NFS partitions, and stop all nfsd
servers: lockd will unregister itself when it sees that it is no
longer needed.

Cheers,
  Trond
