Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVCHDiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVCHDiW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVCGUWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:22:32 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:27578 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261231AbVCGTpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:45:33 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML linux-2.6 latest BK doesn't compile
Date: Mon, 7 Mar 2005 20:44:48 +0100
User-Agent: KMail/1.7.2
Cc: Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <1108380903.22656.9.camel@imp.csi.cam.ac.uk> <200503051945.j25JjIB5003539@ccure.user-mode-linux.org>
In-Reply-To: <200503051945.j25JjIB5003539@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503072044.49206.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 20:45, Jeff Dike wrote:
> aia21@cam.ac.uk said:
> > Yes.  I finally found a way to get it to compile.  Compiling without
> > TT mode and WITHOUT static build it still fails with the same problem
> > (__bb_init_func problem I already reported).  But compiling without TT
> > but WITH static build the __bb_init_func problem goes away but instead
> > I get a __gcov_init missing symbol in my modules.
> >
> > Note I have gcc-3.3.4-11 (SuSE 9.2) and it defines __gcov_init.  So I
> > added this as an export symbol and lo and behold the kernel and
> > modules compiled and I am now up an running with UML and NTFS as a
> > module.  (-:
>
> Can you try this patch?  It exports either __gcov_init or __bb_init_func
> depending on your gcc version.
a) wrong because you say __GNUC_PATCHLEVEL__ > 4 rather than >=
b) wrong because for he the link failed on __bb_init_func at the beginning. So 
in the case you need to export BOTH symbols.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

