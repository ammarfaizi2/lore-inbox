Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTI2Uuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 16:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbTI2Uuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 16:50:44 -0400
Received: from holomorphy.com ([66.224.33.161]:60067 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262221AbTI2Uum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 16:50:42 -0400
Date: Mon, 29 Sep 2003 13:51:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: "J.A. Magallon" <jamagallon@able.es>, Frank Cusack <fcusack@fcusack.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2nd proc not seen
Message-ID: <20030929205140.GQ4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	"J.A. Magallon" <jamagallon@able.es>,
	Frank Cusack <fcusack@fcusack.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030904021113.A1810@google.com> <20030904091437.A25107@google.com> <20030928205045.B21288@google.com> <20030929085807.GA22884@werewolf.able.es> <16247.63409.996071.860727@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16247.63409.996071.860727@gargle.gargle.HOWL>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 11:13:21AM +0200, Mikael Pettersson wrote:
> Problem #1 is that physical CPU numbering isn't dense. This is not a bug.
> Problem #2 is that the kernel's internal dense-logical-to-sparse-physical
> numbering was deleted in 2.5.23 or thereabouts.
> Hence NR_CPUS is basically impossible to use reliably in 2.6 unless we
> reintroduce cpu_logical_map[].

We should be able to at least boot them, since we program logical ID's
ourselves. If you're relying on knowing physids at runtime you'll need
cpu_logical_map[].


-- wli
