Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWAFPpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWAFPpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWAFPpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:45:13 -0500
Received: from host217-46-213-187.in-addr.btopenworld.com ([217.46.213.187]:36387
	"EHLO help.basilica.co.uk") by vger.kernel.org with ESMTP
	id S1751182AbWAFPpM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:45:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] bio: gcc warning fix.
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Fri, 6 Jan 2006 15:48:29 -0000
Message-ID: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] bio: gcc warning fix.
Thread-Index: AcYS1/mA3kyIh6CZRY2zPFal3UIrxQAAI0Ig
From: "Khushil Dep" <khushil.dep@help.basilica.co.uk>
To: "Al Viro" <viro@ftp.linux.org.uk>,
       "Luiz Fernando Capitulino" <lcapitulino@mandriva.com.br>
Cc: "akpm" <akpm@osdl.org>, <axboe@suse.de>,
       "lkml" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder however whether this is not correct? I was always taught to
initialise variables so there is no doubt as to their starting value?

-----------------------
Khushil Dep

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Al Viro
Sent: 06 January 2006 15:40
To: Luiz Fernando Capitulino
Cc: akpm; axboe@suse.de; lkml
Subject: Re: [PATCH] bio: gcc warning fix.

On Fri, Jan 06, 2006 at 01:07:29PM -0200, Luiz Fernando Capitulino
wrote:
> 
>  Fixes the following gcc 4.0.2 warning:
> 
> fs/bio.c: In function 'bio_alloc_bioset':
> fs/bio.c:167: warning: 'idx' may be used uninitialized in this
function

NAK.  There is nothing to fix except for broken logics in gcc.
Please, do not obfuscate correct code just to make gcc to shut up.
Especially for this call of warnings; gcc4 *blows* in that area.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
