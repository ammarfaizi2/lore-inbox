Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVLOSsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVLOSsz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVLOSsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:48:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19162 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750879AbVLOSsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:48:54 -0500
Date: Thu, 15 Dec 2005 13:48:26 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: miles.lane@gmail.com, linux-kernel@vger.kernel.org, greg@kroah.com,
       linux@dominikbrodowski.net, alan@lxorguk.ukuu.org.uk,
       nickpiggin@yahoo.com.au
Subject: Re: 2.6.15-rc5-mm3 -- BUG: using smp_processor_id() in preemptible [00000001] code: swapper/1
Message-ID: <20051215184826.GD19354@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, miles.lane@gmail.com,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	linux@dominikbrodowski.net, alan@lxorguk.ukuu.org.uk,
	nickpiggin@yahoo.com.au
References: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com> <20051215004028.0bf9791f.akpm@osdl.org> <20051215010038.12ca576f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215010038.12ca576f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 01:00:38AM -0800, Andrew Morton wrote:
 > Andrew Morton <akpm@osdl.org> wrote:
 > >
 > > > Here's the BUG output:
 > >  > 
 > >  > [4294671.538000] Freeing unused kernel memory: 220k freed
 > >  > [4294671.538000] BUG: using smp_processor_id() in preemptible
 > >  > [00000001] code: swapper/1
 > >  > [4294671.539000] caller is mod_page_state_offset+0x12/0x28
 > >  > [4294671.539000]  [<c1003723>] dump_stack+0x16/0x1a
 > >  > [4294671.539000]  [<c110c1eb>] debug_smp_processor_id+0x77/0x90
 > >  > [4294671.539000]  [<c10413d3>] mod_page_state_offset+0x12/0x28
 > 
 > This'll plug the above.
 > 
 > Nick, please turn on the nice debugging options in future?

For -mm, perhaps it would make sense to make some of them default to on ?

		Dave

