Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWCGTXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWCGTXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWCGTXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:23:35 -0500
Received: from mx.pathscale.com ([64.160.42.68]:63187 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751569AbWCGTXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:23:34 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: David Howells <dhowells@redhat.com>
Cc: Andi Kleen <ak@suse.de>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <7621.1141756240@warthog.cambridge.redhat.com>
References: <200603071134.52962.ak@suse.de>
	 <31492.1141753245@warthog.cambridge.redhat.com>
	 <7621.1141756240@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 11:23:28 -0800
Message-Id: <1141759408.2617.9.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 18:30 +0000, David Howells wrote:

> True, I suppose. I should make it clear that these accessor functions imply
> memory barriers, if indeed they do,

They don't, but according to Documentation/DocBook/deviceiobook.tmpl
they are performed by the compiler in the order specified.

They also convert between PCI byte order and CPU byte order.  If you
want to avoid that, you need the __raw_* versions, which are not
guaranteed to be provided by all arches.

	<b

