Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVA0Loc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVA0Loc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVA0Loc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:44:32 -0500
Received: from p-mail1.rd.francetelecom.com ([195.101.245.15]:10767 "EHLO
	p-mail1.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S262582AbVA0Lo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:44:29 -0500
Message-ID: <41F8D44D.9070409@francetelecom.REMOVE.com>
Date: Thu, 27 Jan 2005 12:45:17 +0100
From: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch 0/6  virtual address space randomisation
References: <20050127101117.GA9760@infradead.org>
In-Reply-To: <20050127101117.GA9760@infradead.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2005 11:44:26.0485 (UTC) FILETIME=[8DA9CA50:01C50465]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> The randomisation patch series introduces infrastructure and functionality
> that causes certain parts of a process' virtual address space to be
> different for each invocation of the process. The purpose of this is to
> raise the bar on buffer overflow exploits; full randomisation makes it not
> possible to use absolute addresses in the exploit.
> 

I think it is worth mentioning that this is part of PaX ASLR, but with 
some changes and simplification.
I have some questions about the changes:

for RANDMMAP why doing randomization in mmap_base() and not in 
arch_pick_mmap_layout? You miss a whole case here where legacy layout is 
used.

-- 
Julien TINNES - & france telecom - R&D Division/MAPS/NSS
Research Engineer - Internet/Intranet Security
GPG: C050 EF1A 2919 FD87 57C4 DEDD E778 A9F0 14B9 C7D6
