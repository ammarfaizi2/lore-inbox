Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754482AbWKHJj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbWKHJj1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754481AbWKHJj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:39:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4740 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754482AbWKHJj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:39:27 -0500
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <45519033.3060409@qumranet.com>
References: <454E4941.7000108@qumranet.com>
	 <20061107204440.090450ea.akpm@osdl.org>	<adafycuh77b.fsf@cisco.com>
	 <455183EA.2020405@qumranet.com> <20061107233323.c984fa9b.akpm@osdl.org>
	 <45519033.3060409@qumranet.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 10:39:14 +0100
Message-Id: <1162978754.3138.266.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > Would
> > really prefer something at Kconfig-time, but we have no way of letting the
> > assembler version feed into the Kconfig system (nor do we want it, I
> > suspect).
> >   
> 
> config AS_VERSION
>         eval as --version | awk '{ ... }'


config time is not possible (not to mention it's not that uncommon to
config on a different box than you compile). Makefile side is not that
hard; in fact what you'd need is a very small check similar to
scripts/gcc-x86_64-has-stack-protector.sh . While that checks a gcc
feature, checking the VMX operations via a C program with inline asm is
actually the most realistic test ANYWAY ...



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

