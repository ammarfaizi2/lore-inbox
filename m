Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVBLOtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVBLOtE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 09:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVBLOtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 09:49:04 -0500
Received: from mail.suse.de ([195.135.220.2]:55175 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261408AbVBLOtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 09:49:01 -0500
Date: Sat, 12 Feb 2005 15:48:35 +0100
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ray Bryant <raybry@sgi.com>, Hirokazu Takahashi <taka@valinux.co.jp>,
       Hugh DIckins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcello@cyclades.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration -- sys_page_migrate
Message-ID: <20050212144835.GC16075@wotan.suse.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com> <1108211672.4056.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108211672.4056.10.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 07:34:32AM -0500, Arjan van de Ven wrote:
> On Fri, 2005-02-11 at 19:26 -0800, Ray Bryant wrote:
> > This patch introduces the sys_page_migrate() system call:
> > 
> > sys_page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);
> 
> are you really sure you want to expose nodes to userspace via an ABI
> this solid and never changing? To me that feels somewhat like too much
> of an internal thing to expose that will mean that those internals are
> now set in stone due to the interface...

They're already exposed through mbind/set_mempolicy/get_mempolicy and sysfs
of course.

-Andi
