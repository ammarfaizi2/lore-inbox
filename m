Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWJYRW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWJYRW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 13:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWJYRW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 13:22:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16543 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964809AbWJYRW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 13:22:26 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <453F9555.1050201@wolfmountaingroup.com> 
References: <453F9555.1050201@wolfmountaingroup.com>  <16969.1161771256@redhat.com> <5c49b0ed0610250952i2fcc64b7t47fb7565cada14c6@mail.gmail.com> 
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Nate Diller <nate.diller@gmail.com>, sds@tycho.nsa.gov, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 25 Oct 2006 18:21:16 +0100
Message-ID: <25083.1161796876@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey <jmerkey@wolfmountaingroup.com> wrote:

> SELinux support addresses all of these issues for B1 level security quite
> well with mandatory access controls at the fs layers.  In fact, it works so
> well, when enabled you cannot even run apache on top of an FS unless
> configured properly.

How?  The problem I've got is that the caching code would be creating and
accessing files and directories with the wrong security context - that of the
calling process - and not a context suitable for sharing things in the cache
whilst protecting them from userspace as best we can.

David
