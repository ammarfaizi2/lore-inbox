Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265806AbUFOSOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265806AbUFOSOt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUFOSOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:14:49 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:42029 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265806AbUFOSOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:14:41 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dean Nelson <dcn@sgi.com>
Subject: Re: calling kthread_create() from interrupt thread
Date: Tue, 15 Jun 2004 14:14:20 -0400
User-Agent: KMail/1.6.2
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com> <1087321777.2710.43.camel@laptop.fenrus.com> <20040615180525.GA17145@sgi.com>
In-Reply-To: <20040615180525.GA17145@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406151414.20565.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 15, 2004 2:05 pm, Dean Nelson wrote:
> As mentioned above, it is possible for this "simple" function to
> sleep/block for an indefinite period of time. I was under the impression
> that one couldn't block a work queue thread for an indefinite period of
> time. Am I mistaken?

For tasklets and softirqs you're not allowed to sleep, but I think it's ok for 
work queues.

Jesse
