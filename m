Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWFVLlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWFVLlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWFVLlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:41:14 -0400
Received: from fc-cn.com ([218.25.172.144]:28430 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1161062AbWFVLlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:41:13 -0400
Date: Thu, 22 Jun 2006 19:41:26 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [patch] cleanup: kthread workqueue rename
Message-ID: <20060622114126.GA6627@localhost.localdomain>
References: <20060622082912.GA6334@localhost.localdomain> <20060622041316.b290b19d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622041316.b290b19d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 04:13:16AM -0700, Andrew Morton wrote:
> On Thu, 22 Jun 2006 16:29:12 +0800
> Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> 
> > -static struct workqueue_struct *helper_wq;
> > +static struct workqueue_struct *kthread_wq;
> 
> "helper" is better.  It's there to help kthread launching and that's all it
> does.  So "helper" is a more specific identification.


So "khelper_wq" should better be "helper_wq" too?

    khelper_wq = create_singlethread_workqueue("khelper");


'helper_wq' becomes [kthread] as shown in ps ax; I don't think it is a 'helper'.

    5 ?        S<     0:00 [khelper]
    6 ?        S<     0:00 [kthread]

That vague name makes me easily forget what I am looking at.  Please apply.

-- 
Coywolf Qi Hunt
