Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVBSOso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVBSOso (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 09:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVBSOsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 09:48:43 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:60591 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261723AbVBSOsm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 09:48:42 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Pedro Venda <pjvenda@arrakis.dhis.org>
Subject: Re: possible leak in kernel 2.6.10-ac12
Date: Sat, 19 Feb 2005 09:48:11 -0500
User-Agent: KMail/1.7.92
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4213D70F.20104@arrakis.dhis.org> <200502161835.26047.kernel-stuff@comcast.net> <42173323.5060807@arrakis.dhis.org>
In-Reply-To: <42173323.5060807@arrakis.dhis.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502190948.11948.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 February 2005 07:37 am, Pedro Venda wrote:
> biovec-1          1989252 1989478     16  226    1 : tunables  120   60  
>  0 : slabdata   8803   8803      0 bio               1989270 1989271     64
>   61    1 : tunables  120   60    0 : slabdata  32611  32611      0

You have bio leak. Similar one was fixed in -rc4. 
Did you already try using the md fix 
http://linux.bkbits.net:8080/linux-2.6/diffs/drivers/md/md.c@1.234
And
http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fpatch-2.6.10.bz2;z=4918
?

If not, is it possible for you to either port these fixes to -ac12 or use -rc4 
and then report slabinfo after couple of days?

Parag
