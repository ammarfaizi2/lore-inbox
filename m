Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSIDTVG>; Wed, 4 Sep 2002 15:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSIDTVG>; Wed, 4 Sep 2002 15:21:06 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:63631 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S315214AbSIDTVG>; Wed, 4 Sep 2002 15:21:06 -0400
Date: Wed, 4 Sep 2002 20:25:23 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ed Tomlinson <tomlins@cam.org>, William Lee Irwin III <wli@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm1
Message-ID: <20020904202523.A15699@redhat.com>
References: <200209032251.54795.tomlins@cam.org> <3D757F11.B72BB708@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D757F11.B72BB708@zip.com.au>; from akpm@zip.com.au on Tue, Sep 03, 2002 at 08:33:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 03, 2002 at 08:33:37PM -0700, Andrew Morton wrote:

> I *really* think we need to throw away those pages instantly.
> 
> The only possible reason for hanging onto them is because they're
> cache-warm.  And we need a global-scope cpu-local hot pages queue
> anyway.

Yep --- except for caches with constructors, for which we do save a
bit more by hanging onto the pages for longer.

--Stephen
