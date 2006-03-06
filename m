Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752422AbWCFVHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbWCFVHq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbWCFVHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:07:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52889 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752421AbWCFVHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:07:45 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200603061301.37923.dsp@llnl.gov>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <200603061052.57188.dsp@llnl.gov> <20060306195348.GB8777@kroah.com>
	 <200603061301.37923.dsp@llnl.gov>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 22:07:41 +0100
Message-Id: <1141679261.5568.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is it more desirable to dynamically allocate kobjects than to declare
> them statically? 

Yes

>  If so, I'd be curious to know why dynamic
> allocation is preferred over static allocation.

because the lifetime of the kobject is independent of the lifetime of
the memory of your static allocation.
Separate lifetimes -> separate memory is a very good design principle. 

