Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752055AbWG1Ssi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbWG1Ssi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbWG1Ssi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:48:38 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:15745 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1752055AbWG1Ssh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:48:37 -0400
Subject: Re: [patch 5/5] Add the -fstack-protector option to the CFLAGS
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200607282045.05292.ak@suse.de>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
	 <1154102736.6416.19.camel@laptopd505.fenrus.org>
	 <200607282045.05292.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 20:48:31 +0200
Message-Id: <1154112511.6416.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 20:45 +0200, Andi Kleen wrote:
> > +ifdef CONFIG_CC_STACKPROTECTOR
> > +CFLAGS += $(call cc-ifversion, -lt, 0402, -fno-stack-protector)
> > +CFLAGS += $(call cc-ifversion, -ge, 0402, -fstack-protector)
> 
> Why can't you just use the normal call cc-option for this?

this requires gcc 4.2; cc-option is not useful for that.
