Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSGSWAT>; Fri, 19 Jul 2002 18:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSGSWAS>; Fri, 19 Jul 2002 18:00:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36491 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317072AbSGSWAS>;
	Fri, 19 Jul 2002 18:00:18 -0400
Date: Fri, 19 Jul 2002 14:53:24 -0700 (PDT)
Message-Id: <20020719.145324.122050429.davem@redhat.com>
To: spotter@cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: file descriptor passing (jail related question)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1027115899.2161.110.camel@zaphod>
References: <1027115899.2161.110.camel@zaphod>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   From: Shaya Potter <spotter@cs.columbia.edu>
   Date: 19 Jul 2002 17:58:07 -0400

   How does file descriptor passing work.  From what I can tell it uses the
   sendmsg and recvmsg calls.  Is this only process to process over a non
   ip socket  on the same machine (what's the right terminology for this,
   just a plain FIFO?), or could one conceivably pass a file descriptor
   over an ip socket?
   
File descriptors can only be passed over AF_UNIX sockets.
These are like fancy FIFO's on the local host using the
socket APIs for the communication and synchronization.
