Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289415AbSAOEt1>; Mon, 14 Jan 2002 23:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289413AbSAOEtQ>; Mon, 14 Jan 2002 23:49:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21662 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289415AbSAOEtG>;
	Mon, 14 Jan 2002 23:49:06 -0500
Date: Mon, 14 Jan 2002 20:47:04 -0800 (PST)
Message-Id: <20020114.204704.21652738.davem@redhat.com>
To: fds@cs.ucsd.edu
Cc: netdev@oss.sgi.com, ak@muc.de, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org
Subject: Re: New network monitoring proc file.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020114234525.4C84B77BB@bulldog.sacerdoti.org>
In-Reply-To: <20020114234525.4C84B77BB@bulldog.sacerdoti.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Federico David Sacerdoti <fds@cs.ucsd.edu>
   Date: Mon, 14 Jan 2002 15:48:26 -0800

   I would like to submit a patch that adds a /proc file to the kernel which 
   monitors the health of active TCP connections. It does this by counting 
   the number of duplicate ACKs sent out, among other things.
   
   I have a website detailing the exact metrics used and why I choose them:  		
   http://heron.ucsd.edu/tcphealth/
   
I would rather that you add this to the tcp_diag facility in
2.4.x instead of creating yet another proc file.  tcp_diag is
designed perfectly for fetching the kind of information your
TCP health monitor is providing.

This is irregardless of whether your selection of health metrics is
sound or not, I have not looked into this part at all.  But it will
have to be discussed before we think about adding the changes.
