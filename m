Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSGSWc2>; Fri, 19 Jul 2002 18:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSGSWc2>; Fri, 19 Jul 2002 18:32:28 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:56456 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S317115AbSGSWc1>;
	Fri, 19 Jul 2002 18:32:27 -0400
Subject: Re: file descriptor passing (jail related question)
From: Shaya Potter <spotter@cs.columbia.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020719.145324.122050429.davem@redhat.com>
References: <1027115899.2161.110.camel@zaphod> 
	<20020719.145324.122050429.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jul 2002 18:35:24 -0400
Message-Id: <1027118130.2635.128.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks, that AF_UNIX bit was what I needed to find it in stevens.

shaya potter

On Fri, 2002-07-19 at 17:53, David S. Miller wrote:
> 
>    From: Shaya Potter <spotter@cs.columbia.edu>
>    Date: 19 Jul 2002 17:58:07 -0400
> 
>    How does file descriptor passing work.  From what I can tell it uses the
>    sendmsg and recvmsg calls.  Is this only process to process over a non
>    ip socket  on the same machine (what's the right terminology for this,
>    just a plain FIFO?), or could one conceivably pass a file descriptor
>    over an ip socket?
>    
> File descriptors can only be passed over AF_UNIX sockets.
> These are like fancy FIFO's on the local host using the
> socket APIs for the communication and synchronization.


