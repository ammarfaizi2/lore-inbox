Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265303AbSJXDw6>; Wed, 23 Oct 2002 23:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSJXDw6>; Wed, 23 Oct 2002 23:52:58 -0400
Received: from rth.ninka.net ([216.101.162.244]:46999 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265303AbSJXDw5>;
	Wed, 23 Oct 2002 23:52:57 -0400
Subject: Re: [RESEND] tuning linux for high network performance?
From: "David S. Miller" <davem@rth.ninka.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: bert hubert <ahu@ds9a.nl>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200210231542.48673.roy@karlsbakk.net>
References: <200210231218.18733.roy@karlsbakk.net>
	<20021023130101.GA646@outpost.ds9a.nl>
	<1035379308.5950.3.camel@rth.ninka.net> 
	<200210231542.48673.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 21:11:09 -0700
Message-Id: <1035432669.9628.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 06:42, Roy Sigurd Karlsbakk wrote:
> As far as I've understood, sendfile() won't do much good with large files. Is 
> this right?

There is always a benefit to using sendfile(), when you use
sendfile() the cpu doesn't touch one byte of the data if
the network card support TX checksumming.  The disk DMAs
to ram, then the net card DMAs from ram.  Simple as that.

