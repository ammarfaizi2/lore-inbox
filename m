Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUEWIp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUEWIp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 04:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUEWIp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 04:45:29 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26122 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262382AbUEWIp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 04:45:28 -0400
Date: Sun, 23 May 2004 10:44:15 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
Message-ID: <20040523084415.GB16071@alpha.home.local>
References: <20040522234059.GA3735@infradead.org> <1085296400.2781.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085296400.2781.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

On Sun, May 23, 2004 at 09:13:20AM +0200, Arjan van de Ven wrote:
> on first look it seems to be missing a bunch of get_user() calls and
> does direct access instead....

It was intentional for speed purpose. The areas are checked once with
verify_area() when we need to access memory, then data is copied directly
from/to memory. I don't think there's any risk, but I can be wrong.

Regards,
Willy

