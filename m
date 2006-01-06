Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752433AbWAFIiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbWAFIiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbWAFIiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:38:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42927 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752249AbWAFIiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:38:24 -0500
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
From: Arjan van de Ven <arjan@infradead.org>
To: hawkes@sgi.com
Cc: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       John Hesterberg <jh@sgi.com>, Greg Edwards <edwardsg@sgi.com>
In-Reply-To: <20060105213948.11412.45463.sendpatchset@tomahawk.engr.sgi.com>
References: <20060105213948.11412.45463.sendpatchset@tomahawk.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 09:38:18 +0100
Message-Id: <1136536698.2940.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 13:39 -0800, hawkes@sgi.com wrote:
> Increase the generic ia64 config from its current max of 512 CPUs to a
> new max of 1024 CPUs.

I wonder why this would be seen as a sane thing...
Very few people have 1024 cpus, and the ones that do sure would know how
to set 1024 in their kernel config. In fact I would argue to lower it. I
can see the point of keeping it over 64, to give the
more-cpus-than-a-long code more testing, but 512 is too high already..
most people who have ia64 will not have 512 cpus.

(and please don't say "but distributions.." because distributions don't
use the defconfigs anyway)


