Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTERJay (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 05:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTERJax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 05:30:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15781 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262011AbTERJax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 05:30:53 -0400
Date: Sun, 18 May 2003 09:43:41 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: arjanv@redhat.com, jes@wildopensource.com, torvalds@transmeta.com,
       James.Bottomley@steeleye.com, grundler@dsl2.external.hp.com,
       cngam@sgi.com, jeremy@sgi.com, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, wildos@sgi.com
Subject: Re: [patch] support 64 bit pci_alloc_consistent
Message-ID: <20030518094341.A1709@devserv.devel.redhat.com>
References: <16071.1892.811622.257847@trained-monkey.org> <1053250142.1300.8.camel@laptop.fenrus.com> <20030518.023533.98888328.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030518.023533.98888328.davem@redhat.com>; from davem@redhat.com on Sun, May 18, 2003 at 02:35:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 02:35:33AM -0700, David S. Miller wrote:

> WHile logically you are correct, the probing code is going to
> look basically identical.

For most drivers I don't think it will. Most drivers will just say "look I
can do THIS much. I don't give a flying fish about how much of
that you actually use". At least in the probing code. 

In code of say a scsi driver that has to pick some dma descriptor format it's a different
matter of course, but there you have to check SOMETHING, either a variable
you stored during probing, or now the effective mask....
