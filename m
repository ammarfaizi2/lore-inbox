Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbUKECQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUKECQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbUKECQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:16:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18406 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262603AbUKECQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:16:37 -0500
Date: Thu, 4 Nov 2004 21:16:25 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [RFC] [PATCH] [0/6] LSM Stacking
In-Reply-To: <20041104170555.G2357@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0411042057500.21344-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Chris Wright wrote:

> Understood, although I don't think you'll get SELinux folks to agree
> that it could be useful in conjuction with other modules like that.

SELinux folks have differing opinions.  Security module stacking would
obviously be useful for research & development, but there is a question in
my mind of whether this is justification enough for the feature in a
mainline kernel.

If it turns out to be generally useful to stack some security modules,
then it might be better to incorporate their functionality into SELinux
(or some other single module) so that policy and configuration can be
managed and analyzed under one system.

Something to keep in mind is that SELinux is a generic access control
framework specifically designed to allow flexible composition of different
security models under a centralized security policy.

LSM is a useful framework for implementing different security _systems_,
but I don't think it's suitable for composition of security models.  
That's what SELinux is for.

> The real bottom line is that it can't slow anything down for the single
> module case.

Agreed.


- James
-- 
James Morris
<jmorris@redhat.com>


