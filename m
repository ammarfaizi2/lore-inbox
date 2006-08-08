Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWHHRcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWHHRcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWHHRct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:32:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19122 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965014AbWHHRcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:32:48 -0400
Date: Tue, 8 Aug 2006 18:32:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
Message-ID: <20060808173242.GA1739@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paulo Marques <pmarques@grupopie.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20060807115537.GA15253@in.ibm.com> <20060808162421.GA28647@infradead.org> <20060808093400.5f023ea6@localhost.localdomain> <20060808164019.GA3382@infradead.org> <44D8C9BC.40102@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D8C9BC.40102@grupopie.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 06:28:28PM +0100, Paulo Marques wrote:
> Just one side note: kallsyms_lookup_name is _really_ inefficient. The 
> kallsyms structure is tailored so that kallsyms_lookup (the most 
> frequently used function) is really fast. Doing it the other way around 
> involves a O(N) search, uncompressing every symbol name as it goes :P
> 
> I don't think this is really a performance problem for users like 
> kprobes, but I just wanted people to keep in mind that there is a 
> penalty involved in calling kallsyms_lookup_name.

That's true.  One more reason to not expose this interface to the public.
