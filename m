Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWGEKzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWGEKzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 06:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWGEKzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 06:55:07 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:27265 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S964783AbWGEKzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 06:55:05 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: possible recursive locking in ATM layer
Date: Wed, 5 Jul 2006 12:23:33 +0200
User-Agent: KMail/1.9.1
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, chas@cmf.nrl.navy.mil
References: <200607041759.43064.duncan.sands@math.u-psud.fr> <1152029582.3109.70.camel@laptopd505.fenrus.org>
In-Reply-To: <1152029582.3109.70.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607051223.34339.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ok this is a real potential deadlock in a way, it takes two locks of 2
> skbuffs without doing any kind of lock ordering; I think the following
> patch should fix it. Just sort the lock taking order by address of the
> skb.. it's not pretty but it's the best this can do in a minimally
> invasive way.

The patch is effective.  Thanks for making it!

Best wishes,

Duncan.
