Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTJFRHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264017AbTJFRHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:07:20 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:27785 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264018AbTJFRHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:07:19 -0400
Date: Mon, 6 Oct 2003 18:07:07 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: idt change in a running kernel? what locking?
Message-ID: <20031006170707.GA559@mail.shareable.org>
References: <Pine.LNX.4.58.0310030850110.10930@hosting.rdsbv.ro> <20031003063411.GF15691@mail.shareable.org> <Pine.LNX.4.58.0310030945050.10930@hosting.rdsbv.ro> <20031003170210.GA18415@mail.shareable.org> <Pine.LNX.4.58.0310060810440.26313@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310060810440.26313@hosting.rdsbv.ro>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin BOIE wrote:
> What I realy want is to reload idt on every cpu.
> So, probably on_each_cpu is the way to go, right?

Yes.  If you also want to synchronise the changes, so that all CPUs
appear to change idt at the same instant, you'll need some extra
locking.

-- Jamie
