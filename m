Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTFIFGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 01:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTFIFGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 01:06:49 -0400
Received: from waste.org ([209.173.204.2]:9961 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264151AbTFIFGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 01:06:48 -0400
Date: Mon, 9 Jun 2003 00:20:08 -0500
From: Matt Mackall <mpm@selenic.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use valid value when unmapping cpus
Message-ID: <20030609052008.GB31216@waste.org>
References: <3EDE63FE.1010603@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDE63FE.1010603@us.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 02:26:22PM -0700, Matthew Dobson wrote:
> For some unknown reason, we stick a -1 in cpu_2_node when we unmap a cpu 
> on i386.  We're better off sticking a 0 in there, because at least 0 is 
> a valid value if something references it.  -1 is only going to cause 
> problems at some point down the line.

Problems down the line help you find the bogus dereference. Even
better to stick a poison value in there.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
