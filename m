Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUKVVFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUKVVFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUKVVET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:04:19 -0500
Received: from canuck.infradead.org ([205.233.218.70]:58631 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262404AbUKVVBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:01:09 -0500
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
From: Arjan van de Ven <arjan@infradead.org>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: greg@kroah.com, phil@netroedge.com, khali@linux-fr.org,
       sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041122194327.GB4698@penguincomputing.com>
References: <20041102221745.GB18020@penguincomputing.com>
	 <NN38qQl1.1099468908.1237810.khali@gcu.info>
	 <20041103164354.GB20465@penguincomputing.com>
	 <20041118185612.GA20728@penguincomputing.com>
	 <1100945635.2639.31.camel@laptop.fenrus.org>
	 <20041122194327.GB4698@penguincomputing.com>
Content-Type: text/plain
Message-Id: <1101157242.2813.34.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 22 Nov 2004 22:00:42 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?ip=80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > this locking construct is rahter awkward; is it possible to refactor the
> > code such that you can down and up in the same function ?
> 
> Yes, at the cost of some minor code duplication or the introduction of
> another variable.  Is that preferable?  Is holding the lock across function
> calls a Bad Idea?

holding lock across function calls isn't, unlocking in another function than you take the lock is.
For one it makes auditing the code a lot harder.


