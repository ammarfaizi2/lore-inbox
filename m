Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWCHTb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWCHTb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWCHTb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:31:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64749 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932123AbWCHTby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:31:54 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org> 
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>  <20060308184500.GA17716@devserv.devel.redhat.com> <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com> <14275.1141844922@warthog.cambridge.redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@redhat.com>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 08 Mar 2006 19:31:42 +0000
Message-ID: <19984.1141846302@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> Actually, since the different NUMA things may have different paths to the 
> PCI thing, I don't think even the mmiowb() will really help. It has 
> nothing to serialize _with_.

On NUMA PowerPC, should mmiowb() be a SYNC or an EIEIO instruction then? Those
do inter-component synchronisation.

David
