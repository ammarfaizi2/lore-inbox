Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbTFHBZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 21:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTFHBZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 21:25:56 -0400
Received: from holomorphy.com ([66.224.33.161]:64713 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264223AbTFHBZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 21:25:55 -0400
Date: Sat, 7 Jun 2003 18:38:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: rddunlap@osdl.org, colin@colina.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
Message-ID: <20030608013827.GK8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, rddunlap@osdl.org,
	colin@colina.demon.co.uk, linux-kernel@vger.kernel.org
References: <ltptlqb72n.fsf@colina.demon.co.uk> <33435.4.64.196.31.1055008200.squirrel@www.osdl.org> <20030607132432.26846b8a.akpm@digeo.com> <20030607205046.GL20413@holomorphy.com> <20030608005543.GM20413@holomorphy.com> <20030607182843.70079e07.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607182843.70079e07.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 06:28:43PM -0700, Andrew Morton wrote:
> Seems hardly worth the extra arithmetic given that the 2G limit
> is actually bogus?
> I just did mkswap/swapon of a 52G partition.  That used 26MB of lowmem for
> the swap map btw.

It's not clear precisely who or what would benefit from it; however,
the decreased maximum of 32 swapfiles on i386 is a regression vs.
2.4.x's limit of 64, in whatever sense something no one cares about is
actually a regression (in principle they could have merely not spoken
up about it).

In other words, if someone feels itchy because the number went down
from 2.4.x, here it is. If not, I'm fine with leaving it be.


-- wli

P.S.
If desired, I can also send in the code to utilize the extra bits on
PAE, or turn things into a config option, or whatever. Joe Blow random
VM hacker at your service etc.
