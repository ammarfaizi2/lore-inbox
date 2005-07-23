Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVGWAdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVGWAdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 20:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVGWAdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 20:33:41 -0400
Received: from [216.208.38.107] ([216.208.38.107]:28551 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S262258AbVGWAco
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 20:32:44 -0400
Subject: Re: [PATCH] Add
	schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
From: Arjan van de Ven <arjan@infradead.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, domen@coderock.org,
       linux-kernel@vger.kernel.org, clucas@rotomalug.org
In-Reply-To: <20050723002658.GA4183@us.ibm.com>
References: <20050707213138.184888000@homer>
	 <20050708160824.10d4b606.akpm@osdl.org>  <20050723002658.GA4183@us.ibm.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 20:31:55 -0400
Message-Id: <1122078715.5734.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How does something like this look? If this looks ok, I'll send out
> bunches of patches to add users of the new interfaces.

I'd drop the FASTCALL stuff... nowadays with regparm that's automatic
and the cost of register-vs-stack isn't too big anyway


Also I'd rather not add the non-msec ones... either you're raw and use
HZ, or you are "cooked" and use the msec variant.. I dont' see the point
of adding an "in the middle" one. (Yes this means that several users
need to be transformed to msecs but... I consider that progress ;)

