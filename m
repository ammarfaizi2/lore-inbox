Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267711AbUHPPYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267711AbUHPPYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267851AbUHPPYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:24:04 -0400
Received: from main.gmane.org ([80.91.224.249]:63716 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267723AbUHPPUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:20:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Jones <adam@yggdrasl.demon.co.uk>
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Date: Mon, 16 Aug 2004 16:17:46 +0100
Message-ID: <qpv6v1-87i.ln1@yggdrasl.demon.co.uk>
References: <200408160940.02849.worf@sbox.tu-graz.ac.at>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: yggdrasl.demon.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a futile gesture against entropy, Wolfgang Scheicher wrote:
> John Wendel wrote:
> 
> > K3B detects my Lite-on LTR-52327S CDRW as a CDROM when run with 2.6.8.1.
> > Booting back into 2.6.7 corrects the problem.

> I have the same problem.
> I found out that cdrecord has a empty Line for the supported modes.
> ( not k3b fault )

For the record, this also seems to have affected growisofs.  Running it
setuid root doesn't help, since it drops privileges before burning
(and thus I imagine it now ends up dropping too many privileges...).

Would the correct plan of attack here be to send fixes to the authors
of the various media-burning tools to make sure that they keep
CAP_SYS_RAWIO when dropping privileges?  (Are any other capabilities
required?)
-- 
Adam Jones (adam@yggdrasl.demon.co.uk)(http://www.yggdrasl.demon.co.uk/)
.oO("*ahem*"                                                           )
PGP public key: http://www.yggdrasl.demon.co.uk/pubkey.asc

