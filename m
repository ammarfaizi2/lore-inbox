Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262371AbSJKMZB>; Fri, 11 Oct 2002 08:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262372AbSJKMZB>; Fri, 11 Oct 2002 08:25:01 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:35760 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262371AbSJKMZA>; Fri, 11 Oct 2002 08:25:00 -0400
Subject: Re: MTRR and SERVERWORKS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roger While <RogerWhile@sim-basis.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4.3.2.7.2.20021011115225.00c5f480@192.168.6.2>
References: <4.3.2.7.2.20021011115225.00c5f480@192.168.6.2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Oct 2002 13:42:11 +0100
Message-Id: <1034340131.7042.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-11 at 10:55, Roger While wrote:
> Why is MTRR disabled for SERVERWORKS chipset ?
> It works fine on my Asus CUR-DLS after commenting the code out. (2.4 and 
> 2.5)
> Can we at least make it configurable ?

It was originally done for the OSB4. The patch is from Dell citing bugs
that can cause corruption. In the absence of more info I think its
better to be safe.

Adding an __setup() function for something like "mtrr_force" sounds a
good enough idea if you want to submit a patch for it

