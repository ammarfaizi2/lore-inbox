Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbSJ2TaC>; Tue, 29 Oct 2002 14:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSJ2T3j>; Tue, 29 Oct 2002 14:29:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:36324 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262209AbSJ2T2m>; Tue, 29 Oct 2002 14:28:42 -0500
Subject: RedHat nfs-utils-0.3.3.drop-privs.patch problems.
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFABA5F7C6.E14F63CE-ON87256C61.006A538C@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Tue, 29 Oct 2002 11:33:25 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/29/2002 12:33:26
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





I am having trouble when I apply this patch to statd for the following
reason. After the patch does drop_privs() to switch from root to rpcuser
statd_get_socket() is called and it fails to bind to reserved ports
(bindresvport()) as rpcuser is not root. Later when statd tries to notify
lockd of a server going down/back up for example (at the NFS client side)
lockd (in the kernel) refuses to take the notification because it is coming
from a non-priv port (which I think is fine)...

Is this a well-known problem or am I just doing something wrong here?

Regards, Juan

