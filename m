Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVB1Raj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVB1Raj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 12:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVB1Raj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 12:30:39 -0500
Received: from imag.imag.fr ([129.88.30.1]:40065 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261703AbVB1RaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 12:30:19 -0500
Date: Mon, 28 Feb 2005 18:29:39 +0100 (MET)
From: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
X-X-Sender: colbuse@ensisun
To: Stelian Pop <stelian@popies.net>
cc: linux-kernel@vger.kernel.org, <arjan@infradead.org>
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
In-Reply-To: <20050228164456.GB17559@sd291.sivit.org>
Message-ID: <Pine.GSO.4.40.0502281817001.27182-100000@ensisun>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 28 Feb 2005 18:29:47 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Feb 2005, Stelian Pop wrote:

> On Mon, Feb 28, 2005 at 04:06:14PM +0100, colbuse@ensisun.imag.fr wrote:
>
> > +               /* Setting par[]'s elems at 0.  */
> > +               memset(par, 0, NPAR*sizeof(unsigned int));
>
> No need for the comment here, everybody understands C.


I knew this code would be understood, but I like comments :-) .

Well, without it, it gives :



--- old/drivers/char/vt.c 2004-12-24 22:35:25.000000000 +0100
+++ new/drivers/char/vt.c 2005-02-28 18:19:11.782717810 +0100
@@ -1655,8 +1655,8 @@
vc_state = ESnormal;
return;
case ESsquare:
- for(npar = 0 ; npar < NPAR ; npar++)
- par[npar] = 0;
+ memset(par, 0, NPAR*sizeof(unsigned int));
npar = 0;
vc_state = ESgetpars;
if (c == '[') { /* Function key */





Any other comments/remarks, or is _this_ patch version acceptable?


--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - Departement telecoms

