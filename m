Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267713AbRGZKNM>; Thu, 26 Jul 2001 06:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267718AbRGZKNC>; Thu, 26 Jul 2001 06:13:02 -0400
Received: from [194.247.78.171] ([194.247.78.171]:52111 "EHLO
	construct.construct.eu.org") by vger.kernel.org with ESMTP
	id <S267713AbRGZKMt>; Thu, 26 Jul 2001 06:12:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Slawomir Pol <slawomir.pol@mezzonet.net>
Organization: IBS Ltd.
To: <linux-kernel@vger.kernel.org>
Subject: NFS root problem.
Date: Thu, 26 Jul 2001 11:12:17 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.GSO.4.33.0107251342100.14023-100000@noella.mindsec.com>
In-Reply-To: <Pine.GSO.4.33.0107251342100.14023-100000@noella.mindsec.com>
MIME-Version: 1.0
Message-Id: <01072611121700.04058@valis>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,


I have following situation:

Server on 2.4.7 ( with grs pach applied )
Client unit - bootable from floppy ( 2.4.1 kernel ) and it use NFS root from 
server.

The problem is:

(...)
Mounting rootfs read only ( nfs root ) succesfull
Freeing unused kernel memory 198kb
NFS server 192.186.1.45 not responding, still trying.

On server side log contains a message that /usr/src/install was mounted 
succesfuly by client machine.
No other messages about errors.
And normal mounting of this NFS export from any unit on the network ( mount 
-t nfs 192.168.1.45:/usr/src/install /mnt ) works fine.
The problem apeear only when client unit started from floppy try to mount NFS 
root.
The same problem is with 2.4.7-pre6
I haven't tested it on pre4 and pre5.

On 2.4.7-pre3 and all previous kernels it works fine - client boot from NFS 
root as it should.

All test was made on the same machines with the same system configurations - 
only kernels were diffrent.

/etc/export :

/usr/src/install *(rw,no_root_squash)




Slawomir Pol
