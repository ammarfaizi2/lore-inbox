Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268954AbUIXRiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbUIXRiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268944AbUIXRiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:38:20 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:64333 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268979AbUIXRhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:37:37 -0400
Message-ID: <5b64f7f04092410367c6328e0@mail.gmail.com>
Date: Fri, 24 Sep 2004 17:36:48 +0000
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: "Johnson, Richard" <rjohnson@analogic.com>
Subject: Re: Migration to linux-2.6.8 from linux-2.4.26
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0409241258180.24517@quark.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.53.0409241038250.24372@quark.analogic.com>
	 <5b64f7f040924093035495d74@mail.gmail.com>
	 <Pine.LNX.4.53.0409241258180.24517@quark.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Fri, 24 Sep 2004 11:10:23 -0400 (EDT), Johnson, Richard
> I don't know how it 'knew' that I had proviously copied
> all the modutil utilities to *.old before installing the
> new ones. In any event, it would certainly never find
> them at "./filename.old". They would have to be un
> /sbin or /usr/sbin or /usr/local/something, never in
> the current directory.

Aha, there's the problem. module-init-tools does a copy of the old
tools itself and delegates to the old tools for 2.4 kernels. So to fix
your problem, install modutils and the install module-init-tools over
it. See the README file that comes with module-init-tools for further
info.

Thanks,
Rahul
