Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318041AbSGLWfL>; Fri, 12 Jul 2002 18:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318042AbSGLWfK>; Fri, 12 Jul 2002 18:35:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53164 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318041AbSGLWfK>;
	Fri, 12 Jul 2002 18:35:10 -0400
Date: Fri, 12 Jul 2002 15:28:42 -0700 (PDT)
Message-Id: <20020712.152842.85820158.davem@redhat.com>
To: akpm@zip.com.au
Cc: alan@lxorguk.ukuu.org.uk, matts@ksu.edu, shemminger@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 64 bit netdev stats counter
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D2F57BD.E9ABBBCA@zip.com.au>
References: <1026516053.9958.33.camel@irongate.swansea.linux.org.uk>
	<20020712.150607.35506145.davem@redhat.com>
	<3D2F57BD.E9ABBBCA@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Fri, 12 Jul 2002 15:27:09 -0700
   
   Could you make the counters per-cpu and only add them all up
   in the rare case where someone wants to read the stats?
   
   And then change all the drivers ;)

Since spinlocks are held %99 of the time when these counters are
bumped, I'd like to suggest another more sane and space optimized
solution :-)
