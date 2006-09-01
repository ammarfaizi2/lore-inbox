Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWIAKV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWIAKV5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 06:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWIAKV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 06:21:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:17871 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750907AbWIAKV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 06:21:56 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Fri, 1 Sep 2006 12:21:36 +0200
User-Agent: KMail/1.9.3
Cc: Badari Pulavarty <pbadari@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@osdl.org>
References: <200609010615_MC3-1-C9FA-ECE6@compuserve.com>
In-Reply-To: <200609010615_MC3-1-C9FA-ECE6@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609011221.36718.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Sometimes this is caused by tail calls, i.e. when the last line
> of a function calls another function it can many times be optimized
> into a jump.
> 
> You can disable this by compiling with CONFIG_FRAME_POINTER=y.

Even that will not disable automatic inlining, which is probably causing most
of the missing frames here.

-Andi
