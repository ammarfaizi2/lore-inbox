Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262984AbVALAMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbVALAMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVALAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:09:50 -0500
Received: from holomorphy.com ([207.189.100.168]:60391 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262964AbVALAHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:07:40 -0500
Date: Tue, 11 Jan 2005 16:07:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Wright <chrisw@osdl.org>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: node_online_map patch kills x86_64
Message-ID: <20050112000726.GD14443@holomorphy.com>
References: <20050111151656.A24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111151656.A24171@build.pdx.osdl.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 03:16:56PM -0800, Chris Wright wrote:
> Backing out the x86_64 specific bits of the numnodes -> node_online_map
> patch and the generic bits from wli, kills my machine at boot.
> It hits the early_idt_handler and dies straight away.  What would help
> to debug this thing?

The only part of this I'm responsible for is converting build_zonelists()
to pass its nodemask argument by reference to address a livelock. I feel
your pain and if not otherwise occupied I would help fix your problem
right away.


-- wli
