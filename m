Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTLETte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTLETte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:49:34 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:12471 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S264327AbTLETtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:49:32 -0500
Date: Fri, 5 Dec 2003 14:47:56 -0500
Message-Id: <200312051947.hB5Jlupp030878@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Matthew Wilcox <willy@debian.org>
Cc: Erez Zadok <ezk@cs.sunysb.edu>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem 
In-reply-to: Your message of "Fri, 05 Dec 2003 19:14:47 GMT."
             <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info, Matthew.  Yes, clearly a scheme that keeps some "holes"
in compressed files can help; one of our ideas was to leave sparse holes
every N blocks, exactly for this kind of expansion, and to update the index
file's format to record where the spaces are (so we can efficiently
calculate how many holes we need to consume upon a new write).

Cheers,
Erez.
