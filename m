Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVBLMek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVBLMek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 07:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVBLMek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 07:34:40 -0500
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:62682 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261397AbVBLMej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 07:34:39 -0500
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
	sys_page_migrate
From: Arjan van de Ven <arjan@infradead.org>
To: Ray Bryant <raybry@sgi.com>
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, Hugh DIckins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcello@cyclades.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	 <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
Content-Type: text/plain
Date: Sat, 12 Feb 2005 07:34:32 -0500
Message-Id: <1108211672.4056.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2005 12:34:33.0620 (UTC) FILETIME=[34AA2D40:01C510FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 19:26 -0800, Ray Bryant wrote:
> This patch introduces the sys_page_migrate() system call:
> 
> sys_page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);

are you really sure you want to expose nodes to userspace via an ABI
this solid and never changing? To me that feels somewhat like too much
of an internal thing to expose that will mean that those internals are
now set in stone due to the interface...


