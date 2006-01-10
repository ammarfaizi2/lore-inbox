Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWAJTIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWAJTIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWAJTIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:08:04 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:32270 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751289AbWAJTIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:08:02 -0500
Date: Tue, 10 Jan 2006 20:07:39 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: anil dahiya <ak_ait@yahoo.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: makefile for 2.6 kernel
Message-ID: <20060110190739.GA13228@mars.ravnborg.org>
References: <20060104182356.14925.qmail@web60217.mail.yahoo.com> <20060110174419.56611.qmail@web60212.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110174419.56611.qmail@web60212.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 09:44:19AM -0800, anil dahiya wrote:
> Hi Sam
> Thanks fop your help ..but my problem is not solved it
> ...i putting my real problem here below.
> 
> 1>my fist need is to make  module1.ko made using
> a1/a1.c , a1/a11.c & a2/a2.c a2/a22.c and all .c file
> use /home/include/a.h 
This was covered in my first response.

>  
> 2>Now my 2nd need is to make module2.ko using
> module1.ko and b/b1.c & b/b11.c (these both .c files
> use /home/include/a.h and /home/module2/include/b.h) 
This does not make sense. You cannot link in one module
into anohter. And you would not be able to use module1
with module2 loaded due to name clash.

But you can certainly call one module from another module.
You just have to make sure module1 is loaded before module2.

Last time I requested an URL to the source IIRC?

	Sam
