Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRIXVHQ>; Mon, 24 Sep 2001 17:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269646AbRIXVHI>; Mon, 24 Sep 2001 17:07:08 -0400
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:47744 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S269693AbRIXVGw>; Mon, 24 Sep 2001 17:06:52 -0400
Date: Mon, 24 Sep 2001 23:03:46 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010924230345.A1540@localhost.localdomain>
In-Reply-To: <20010924040208.A624@localhost.localdomain> <Pine.LNX.4.21.0109240810300.1593-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0109240810300.1593-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Sep 24, 2001 at 08:12:20AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 08:12:20AM -0300, Marcelo Tosatti wrote:
> Jacek, 
> 
> You had available swap when the VM started to kill processes ? 

Application eats whole memory, then started using swap, when swap used is 10MB
kernel starting to cry:

[root@localhost /root]# free
             total       used       free     shared    buffers     cached
Mem:        320616     317348       3268          0        120     304096
-/+ buffers/cache:      13132     307484
Swap:       104380      10208      94172
[root@localhost /root]# free
             total       used       free     shared    buffers     cached
Mem:        320616     318932       1684          0        136     305372
-/+ buffers/cache:      13424     307192
Swap:       104380      10072      94308
[root@localhost /root]# __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
free
             total       used       free     shared    buffers     cached
Mem:        320616     318884       1732          0        128     305636
-/+ buffers/cache:      13120     307496
Swap:       104380      10204      94176
[root@localhost /root]# __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
VM: killing process donkey_s
free
             total       used       free     shared    buffers     cached
Mem:        320616     318732       1884          0        116     305480
-/+ buffers/cache:      13136     307480
Swap:       104380       9312      95068

