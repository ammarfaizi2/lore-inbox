Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbTEaNyD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 09:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTEaNyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 09:54:03 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:10 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264325AbTEaNyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 09:54:02 -0400
Date: Sat, 31 May 2003 15:07:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [patch] 2.5.70-mm3: sdla.c doesn't compile
Message-ID: <20030531150719.A32067@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20030531013716.07d90773.akpm@digeo.com> <20030531135610.GI2536@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030531135610.GI2536@fs.tum.de>; from bunk@fs.tum.de on Sat, May 31, 2003 at 03:56:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 03:56:10PM +0200, Adrian Bunk wrote:
> It seems the following compile error when trying to compile sdla,c 
> statically into the kernel comes from Linus' tree:

Argg, #ifdef MODULE considered harmful..

> I'm not sure whether the following is the best solution but it fixes the 
> problem:

The right fix would be to make exit_sdla and module_exit #ifdef MODULE.
I'll cook up a patch once I have access to a source tree again (=monday)
unless you're faster :)

