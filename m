Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755279AbWKMUjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279AbWKMUjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbWKMUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:39:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60065 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755279AbWKMUjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:39:12 -0500
Subject: Re: overriding BIOS (was: Re: [ANNOUNCE] kvm howto)
From: Arjan van de Ven <arjan@infradead.org>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kvm-devel@lists.sourceforge.net
In-Reply-To: <20061113203421.GA5363@irc.pl>
References: <20061105171424.GA7045@irc.pl>
	 <64F9B87B6B770947A9F8391472E0321608EBF537@ehost011-8.exch011.intermedia.net>
	 <20061113203421.GA5363@irc.pl>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 21:39:05 +0100
Message-Id: <1163450346.15249.209.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 21:34 +0100, Tomasz Torcz wrote:
> On Mon, Nov 06, 2006 at 12:15:02AM -0800, Dor Laor wrote:
> > The BIOS check is a must, it checks bit #0 of MSR_IA32_FEATURE_CONTROL,
> > if it set this means that software cannot write to the MSR. If bit #2 is
> > clear too then when executing vmxon you'll get #GP.
> > 
> > So the check should better be there...
> 
>   You were right, just writing to this MSR (via kvm_enable) halts my laptop.
>  Which is kinda strange, as this solution works on Intel Mac Minis.
> 
>   Anyway, complaint to Lenovo sent and got ignored.
> 

the linux-ready firmware developer kit now tries to test for this; with
some luck the bios people will run this and fix it ;)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

