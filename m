Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbSJCPOy>; Thu, 3 Oct 2002 11:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSJCPOa>; Thu, 3 Oct 2002 11:14:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14547 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261327AbSJCPOY>;
	Thu, 3 Oct 2002 11:14:24 -0400
Date: Thu, 03 Oct 2002 08:11:09 -0700 (PDT)
Message-Id: <20021003.081109.35889528.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: willy@debian.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Start of cleaning up socket ioctls
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1033658599.28850.5.camel@irongate.swansea.linux.org.uk>
References: <20021003155241.G28586@parcelfarce.linux.theplanet.co.uk>
	<1033658599.28850.5.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 03 Oct 2002 16:23:19 +0100
   
   Nice but one request - can you call the protocol handlers first and if
   they return -ENOTTY then call the default ones provided by the upper
   layer. That will let you remove even more common code to most versions,
   make it work like the serial and other layers do, and still let people
   override defaults
   
Actually the cases he removed this round I am reasonably certain no
protocol should ever need to override.
