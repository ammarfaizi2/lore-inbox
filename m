Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264073AbUE0MmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUE0MmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUE0MmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:42:22 -0400
Received: from holomorphy.com ([207.189.100.168]:16007 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262114AbUE0MmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:42:08 -0400
Date: Thu, 27 May 2004 05:41:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: Andy Lutomirski <luto@myrealbox.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Tom Felker <tcfelker@mtco.com>,
       Matthias Schniedermeyer <ms@citd.de>, linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040527124145.GD22648@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
	Andy Lutomirski <luto@myrealbox.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Tom Felker <tcfelker@mtco.com>,
	Matthias Schniedermeyer <ms@citd.de>, linux-kernel@vger.kernel.org
References: <5D3C2276FD64424297729EB733ED1F7606242C53@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D3C2276FD64424297729EB733ED1F7606242C53@email1.mitretek.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 08:31:26AM -0400, Piszcz, Justin Michael wrote:
> If I have 16GB of ram should I use swap?
> Would swap cause the machine to slow down?

Yes. You want swap so you can physically relocate anonymous pages in the
rare case one ends up somewhere it could cause memory pressure against
allocations that can only be satisfied by a restricted range of memory.


-- wli
