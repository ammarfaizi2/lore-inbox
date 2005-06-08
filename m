Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVFHG3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVFHG3o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 02:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVFHG3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 02:29:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10390 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262118AbVFHG3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 02:29:42 -0400
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87hdg9eq0u.fsf@jbms.ath.cx>
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
	 <20050607194123.GA16637@infradead.org>
	 <Pine.LNX.4.62.0506071258450.2850@ScMPusgw>
	 <1118177949.5497.44.camel@laptopd505.fenrus.org>
	 <42A61227.9090402@didntduck.org>
	 <Pine.LNX.4.62.0506071519470.19659@ScMPusgw>  <87hdg9eq0u.fsf@jbms.ath.cx>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 08:29:38 +0200
Message-Id: <1118212178.5655.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 18:54 -0400, Jeremy Maitin-Shepard wrote:
> christoph <christoph@scalex86.org> writes:
> 
> > On Tue, 7 Jun 2005, Brian Gerst wrote:
> >> It doesn't really matter.  .rodata isn't actually mapped read-only. Doing so
> >> would break up the large pages used to map the kernel.
> 
> > In that case.... here is a patch that moves the table into rodata.
> 
> AFS writes to the system call table.  

afaik they stopped doing that for 2.6 now that the syscall table isn't
exported.


