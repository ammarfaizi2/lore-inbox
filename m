Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUFNKX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUFNKX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 06:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUFNKX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 06:23:56 -0400
Received: from [213.146.154.40] ([213.146.154.40]:63699 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262238AbUFNKXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 06:23:55 -0400
Date: Mon, 14 Jun 2004 11:23:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [12/12] fix thread_info.h ignoring __HAVE_THREAD_FUNCTIONS
Message-ID: <20040614102352.GA11844@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com> <20040614004354.GX1444@holomorphy.com> <20040614004516.GY1444@holomorphy.com> <20040614004701.GZ1444@holomorphy.com> <20040614004855.GA1444@holomorphy.com> <20040614081639.GI7162@infradead.org> <Pine.LNX.4.58.0406141032210.10292@scrub.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406141032210.10292@scrub.local>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 12:19:12PM +0200, Roman Zippel wrote:
> There is another pending change in this department: current_thread_info(). 
> For all nonbroken archs which have proper thread register it would 
> actually be beneficial, to keep the task structure and thread info 
> together and access them via the thread register, but a certain arch 
> and include dependencies forces everyone to derive the thread info pointer 
> from the stack pointer.

ia64 actually has thread_info and task_info in a single allocation and
uses a thread register to find that one.

