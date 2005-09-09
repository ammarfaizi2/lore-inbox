Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVIILRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVIILRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbVIILRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:17:12 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:19487 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1030244AbVIILRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:17:11 -0400
Date: Fri, 9 Sep 2005 12:17:03 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Consistently use the name asm-offsets.h
Message-ID: <20050909111703.GD3747@linux-mips.org>
References: <20050908211539.GA24714@mars.ravnborg.org> <20050908214741.GA16421@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908214741.GA16421@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 11:47:42PM +0200, Sam Ravnborg wrote:

> mips has it own private gen-asm-offset macro,
> 
> The important part being:
> 
> sed -ne "/^@@@/s///p"; \
> 
> compared to the generic one:
> 
> sed -ne "/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"; \
> 
> I wonder why the assembly for mips is so different...
> So for now two architectures needs special care: mips and ia64.

MIPS uses it's own rules only for readability of the generated file.

  Ralf
