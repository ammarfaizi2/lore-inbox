Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbTD3PkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbTD3PkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:40:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262334AbTD3Pj4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:39:56 -0400
Date: Wed, 30 Apr 2003 08:49:44 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christian =?ISO-8859-1?Q?Borntr=E4ger?= <linux@borntraeger.net>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.5.67 (and probably earlier)] /proc/dev/net doesnt show
 all net devices
Message-Id: <20030430084944.5ac3626a.rddunlap@osdl.org>
In-Reply-To: <200304300911.11287.linux@borntraeger.net>
References: <200304291434.18272.linux@borntraeger.net>
	<20030429092857.4ebffcc9.rddunlap@osdl.org>
	<20030429130742.2c38b5f3.rddunlap@osdl.org>
	<200304300911.11287.linux@borntraeger.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003 09:11:11 +0200 Christian Bornträger <linux@borntraeger.net> wrote:

| > | Christian, can you test this patch?
| 
| I can....
| 
| > Oh well, I don't think that works.
| 
| should I nevertheless test this patch?

You didn't need to.  I had already seen the same results that you saw.

| > How do I configure the dummy network driver to get loads of interfaces?
| 
| Just copy the dummy.o to dummy1.o dummy2.o dummy3.o,  insmod and ifconfig 
| them.

Doesn't work for me.  insmod (from ver. 0.9.11a module-init-tools)
won't load multiple copies of dummy[n].o or dummy[n].ko.
(with dummy already loaded)

For the .o files, it says:
  dummy: no version magic, tainting kernel.
  Error inserting 'dummy1.o': -1 File exists

and for the .ko files, it says:
  Error inserting 'dummy1.ko': -1 File exists

--
~Randy
