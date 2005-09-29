Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVI2BP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVI2BP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVI2BP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:15:58 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:16655 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S1750792AbVI2BP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:15:58 -0400
Subject: RE: Registering for multiple SIGIO within a process
From: Ray Lee <ray-lk@madrabbit.org>
To: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>
Cc: "Bhattacharjee, Satadal" <Satadal.Bhattacharjee@engenio.com>,
       linux-kernel@vger.kernel.org,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Ram, Hari" <hari.ram@engenio.com>,
       "Mukker, Atul" <Atul.Mukker@engenio.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CD1EB@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E57060CD1EB@exa-atlanta>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Wed, 28 Sep 2005 18:15:50 -0700
Message-Id: <1127956550.25462.15.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 20:44 -0400, Bagalkote, Sreenivas wrote:
> >(Sheesh, what is it with people thinking signals are something 
> >to be used in any design after the 1970's?)
> What's your recommendation for asynchronous notification from driver
> to an application?

Pass back an fd to select() upon. Cuts out that nasty middle step where
app authors end up registering a signal handler that merely write()s the
signal number down a pipe into the (nearly ubiquitous) select loop.

Ray

