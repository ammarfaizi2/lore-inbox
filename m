Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTEFVIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEFVHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:07:09 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:7044 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S261881AbTEFVGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:06:39 -0400
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
	defined (trivial)
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Horsten <thomas@horsten.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200305061510.04619.thomas@horsten.com>
References: <20030506103823.B27816@infradead.org>
	 <20030506104956.A29357@infradead.org>
	 <1052215397.983.25.camel@rth.ninka.net>
	 <200305061510.04619.thomas@horsten.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052255946.7532.66.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 06 May 2003 22:19:06 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: thomas@horsten.com, davem@redhat.com, hch@infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 15:10, Thomas Horsten wrote:
> I see where you're coming from, but not being able to compile existing
> applications where they are never used but need to include e.g.
> cdrom.h, is IMHO even worse.

The correct fix is to provide a userland-only version of cdrom.h which
doesn't use the private kernel types.h. Or a file containing _only_
those parts which can be shared between kernel and userland, defined
using standard types such as uint32_t etc. 

-- 
dwmw2


