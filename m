Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTLKG4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 01:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTLKG4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 01:56:19 -0500
Received: from holomorphy.com ([199.26.172.102]:44004 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264368AbTLKG4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 01:56:19 -0500
Date: Wed, 10 Dec 2003 22:55:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Darren Dupre <darren@dmdtech.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cifs causes high system load avg, oopses when unloaded on 2.6.0-test11
Message-ID: <20031211065535.GZ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Darren Dupre <darren@dmdtech.org>, linux-kernel@vger.kernel.org
References: <001801c3bfb1$e734ce20$1e01a8c0@dmdtech2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001801c3bfb1$e734ce20$1e01a8c0@dmdtech2>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 12:42:10AM -0600, Darren Dupre wrote:
> Using CIFS causes a very high load average (approx. 12 according to uptime).
> After I umout all filesystems (CIFS ones) and then unload the module, it
> oopses (below).
> CC me replies if more information is needed.

Hmm, this unload needs to hand back failure to module unload when it
can't nuke inodes etc. I'd suggest not using it as a module for the
time being.


-- wli
