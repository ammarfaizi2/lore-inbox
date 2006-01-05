Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751960AbWAEF57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbWAEF57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 00:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWAEF56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 00:57:58 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:46475 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751960AbWAEF56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 00:57:58 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] fix workqueue oops during cpu offline
Date: Thu, 5 Jan 2006 15:58:13 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Ben Collins <bcollins@debian.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060105045810.GE16729@localhost.localdomain>
In-Reply-To: <20060105045810.GE16729@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051558.14275.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thursday 05 January 2006 14:58, Nathan Lynch wrote:
> With 2.6.15, powerpc systems oops when cpu 0 is offlined.  This is a
> regression from 2.6.14, caused by commit id
> bce61dd49d6ba7799be2de17c772e4c701558f14 ("Fix hardcoded cpu=0 in
> workqueue for per_cpu_ptr() calls").

So it's valid on ppc for cpu 0 to be taken offline? IIRC, trying that on my P4 
a while back did nothing. I think you'll find other places that assume that 
cpu 0 is always up (swsusp? ... I should check suspend2).

Regards,

Nigel
