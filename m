Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUFEVRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUFEVRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUFEVRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:17:14 -0400
Received: from cantor.suse.de ([195.135.220.2]:20170 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262451AbUFEVRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:17:05 -0400
Date: Sat, 5 Jun 2004 23:17:01 +0200
From: Olaf Hering <olh@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check missing
Message-ID: <20040605211701.GD1134@suse.de>
References: <20040605204334.GA1134@suse.de> <20040605140153.6c5945a0.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040605140153.6c5945a0.davem@redhat.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jun 05, David S. Miller wrote:

> I can't see a reason, can anyone else?  If there is no reason, the
> right fix is simply to mask it out at the top level, for both
> sendmsg and recvmsg.

I did it first this way, but the result was a long delay until the dhcp
server replied, the patch sent earlier leads to a fast reply.

    err = sock_recvmsg(sock, &msg_sys, total_len, flags & ~MSG_CMSG_COMPAT);
 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
