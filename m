Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318156AbSGPX7m>; Tue, 16 Jul 2002 19:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSGPX7l>; Tue, 16 Jul 2002 19:59:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7897 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318156AbSGPX7k>;
	Tue, 16 Jul 2002 19:59:40 -0400
Date: Tue, 16 Jul 2002 16:52:41 -0700 (PDT)
Message-Id: <20020716.165241.123987278.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: zack@codesourcery.com, linux-kernel@vger.kernel.org
Subject: Re: close return value
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
References: <20020716232225.GH358@codesourcery.com>
	<1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 17 Jul 2002 02:03:02 +0100
   
   close() checking is not about physical disk guarantees. It's about more
   basic "I/O completed". In some future Linux only close() might tell you
   about some kinds of I/O error. The fact it doesn't do it now is no
   excuse for sloppy programming

Practice dictates that if you make close() return error values
your whole system will blow up.  Try it out for yourself.
I can tell you of at least 1 app that is going to explode :-)

I believe Linus mentioned way back when that this is a "shall not"
when we had similar problems with NFS returning errors from close().
