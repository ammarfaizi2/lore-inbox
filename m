Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268209AbTBWKDY>; Sun, 23 Feb 2003 05:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268199AbTBWKCO>; Sun, 23 Feb 2003 05:02:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57821 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268189AbTBWKBW>;
	Sun, 23 Feb 2003 05:01:22 -0500
Date: Sun, 23 Feb 2003 01:55:11 -0800 (PST)
Message-Id: <20030223.015511.63413067.davem@redhat.com>
To: hch@infradead.org
Cc: ak@suse.de, sim@netnation.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030223100234.B15347@infradead.org>
References: <20030221104541.GA18417@wotan.suse.de>
	<20030223.011217.04700323.davem@redhat.com>
	<20030223100234.B15347@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Sun, 23 Feb 2003 10:02:34 +0000

   On Sun, Feb 23, 2003 at 01:12:17AM -0800, David S. Miller wrote:
   > +static struct socket *__icmp_socket[NR_CPUS];
   > +#define icmp_socket	__icmp_socket[smp_processor_id()]
   
   This should be per-cpu data
   
My bad.  Thanks for spotting this.
