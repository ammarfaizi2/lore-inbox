Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267795AbUHRVS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267795AbUHRVS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUHRVRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:17:04 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:28869 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267849AbUHRVPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:15:47 -0400
Date: Wed, 18 Aug 2004 14:15:41 -0700
From: Paul Jackson <pj@sgi.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-Id: <20040818141541.467e1e2d.pj@sgi.com>
In-Reply-To: <20040818135401.670f11bd.davem@redhat.com>
References: <20040818133348.7e319e0e.pj@sgi.com>
	<20040818135401.670f11bd.davem@redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Miller wrote:
> Each platform needs different args, unfortunately.

Doesn't that make it kinda rough on the folks trying to write
arch-independent code, such as sound/core/pcm_native.c that I am
tripping over?

I can imagine a possible 'solution' something like (1) always passing
six args, and (2) providing arch-dependent macros to generate those last
two args, from some arch-generic value.

Just brainstorming ...

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
