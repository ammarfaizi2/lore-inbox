Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265140AbUEYWw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbUEYWw1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbUEYWw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:52:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34978 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265140AbUEYWwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:52:25 -0400
Date: Tue, 25 May 2004 19:53:53 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Doug Dumitru <doug@easyco.com>, linux-kernel@vger.kernel.org,
       cramerj <cramerj@intel.com>, "Ronciak, John" <john.ronciak@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>, jgarzik@pobox.com
Subject: Re: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1) - Not out of memory
Message-ID: <20040525225353.GB5344@logos.cnet>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF618C@orsmsx402.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF618C@orsmsx402.amr.corp.intel.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 02:20:23PM -0700, Feldman, Scott wrote:
> Marcelo Tosatti wrote:
> 
> > It seems we are calling alloc_skb(GFP_KERNEL) from inside an 
> > interrupt handler. Oops. 
> 
> We're calling dev_alloc_skb() from hard interrupt context, but it uses
> GFP_ATOMIC, not GFP_KERNEL, so this is OK, right?  I don't see the
> problem with e1000.  

Scott,

I'm full of sh*t, just ignore me.
