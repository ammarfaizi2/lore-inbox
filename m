Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVC3CII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVC3CII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 21:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVC3CII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 21:08:08 -0500
Received: from main.gmane.org ([80.91.229.2]:26845 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261716AbVC3CID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 21:08:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH] embarassing typo
Date: Wed, 30 Mar 2005 04:07:39 +0200
Message-ID: <yw1xu0mtzy1g.fsf@ford.inprovide.com>
References: <1112128584.25954.6.camel@tux.lan> <yw1xd5ti17z6.fsf@ford.inprovide.com>
 <4249CFA1.7050907@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:RIVdTBfWsaSM0A4DFuoDp8Rw0mk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev <mjt@tls.msk.ru> writes:

> Måns Rullgård wrote:
>> "Ronald S. Bultje" <rbultje@ronald.bitfreak.net> writes:
>>
>>>--- linux-2.6.5/drivers/media/video/zr36050.c.old	16 Sep 2004 22:53:27 -0000	1.2
>>>+++ linux-2.6.5/drivers/media/video/zr36050.c	29 Mar 2005 20:30:23 -0000
>>>@@ -419,7 +419,7 @@
>>> 	dri_data[2] = 0x00;
>>> 	dri_data[3] = 0x04;
>>> 	dri_data[4] = ptr->dri >> 8;
>>>-	dri_data[5] = ptr->dri * 0xff;
>>>+	dri_data[5] = ptr->dri & 0xff;
>> Hey, that's a nice obfuscation of a simple negation.
>
> It's not a negation.  This statement always assigns zero to
> dri_data[5] if dri_data is char[].

Sure about that?

__u16 i;
char c;
i = 1; c = i * 255; /* c = 255 = -1 */
i = 2; c = i * 255; /* c = 510 & 0xff = 254 = -2 */
...

Looks like negation to me.

-- 
Måns Rullgård
mru@inprovide.com

