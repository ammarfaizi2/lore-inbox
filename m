Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWHHQk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWHHQk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWHHQk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:40:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20372 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964990AbWHHQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:40:25 -0400
Date: Tue, 8 Aug 2006 17:40:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
Message-ID: <20060808164019.GA3382@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20060807115537.GA15253@in.ibm.com> <20060808162421.GA28647@infradead.org> <20060808093400.5f023ea6@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808093400.5f023ea6@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 09:34:00AM -0700, Stephen Hemminger wrote:
> Okay, does this makes kprobe's the first reflective kernel interface.

Actually kallsyms_lookup_name was the first interface like that.  And lots
of external kprobes used it like that - in fact tcp_probe.c is the first
one I've seen doing it differently.  But kallsyms_lookup_name is a really
awkward lowlevel buildingblock that's almost impossible to use correctly,
so this patch hides it behind the proper kprobes interface.

