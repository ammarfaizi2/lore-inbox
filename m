Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbTLXK4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 05:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTLXK4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 05:56:40 -0500
Received: from holomorphy.com ([199.26.172.102]:58278 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263544AbTLXK4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 05:56:39 -0500
Date: Wed, 24 Dec 2003 02:55:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ioe-lkml@rameria.de, shemminger@osdl.org,
       sylvain.jeaugey@bull.net, raybry@sgi.com, hch@infradead.org,
       Simon.Derr@bull.net
Subject: Re: [PATCH] another minor bit of cpumask cleanup
Message-ID: <20031224105555.GF27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Rusty Russell <rusty@rustcorp.com.au>,
	akpm@osdl.org, linux-kernel@vger.kernel.org, ioe-lkml@rameria.de,
	shemminger@osdl.org, sylvain.jeaugey@bull.net, raybry@sgi.com,
	hch@infradead.org, Simon.Derr@bull.net
References: <20031223021039.5b99a04b.pj@sgi.com> <20031224023632.5D5462C260@lists.samba.org> <20031223191835.26c974f2.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223191835.26c974f2.pj@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, rusty wrote:
>> In 2.7, my aim is to switch the rest of them, move more things to
>> per-cpu rather than [NR_CPUS] arrays, add the more efficient dynamic
>> per-cpu allocation, and spread the per-cpu religion by fire and the
>> sword.

On Tue, Dec 23, 2003 at 07:18:35PM -0800, Paul Jackson wrote:
> For folks doing really large cpu counts, like my employer, this might
> become of interest sooner.  On the other hand, we do really large memory
> as well, so this might not be especially critical to us.
> If NR_CPUS arrays start to annoy us sooner, I'll know where to consult.

This is primarily for the purpose of data placement, i.e. for node-local
per-cpu elements. That said, to each his own.


-- wli
