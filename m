Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263257AbTEMG6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTEMG6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:58:05 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:39429 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263257AbTEMG6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:58:03 -0400
Date: Tue, 13 May 2003 08:10:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ben Collins <bcollins@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030513081032.A7184@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ben Collins <bcollins@debian.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030513062640.GR433@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030513062640.GR433@phunnypharm.org>; from bcollins@debian.org on Tue, May 13, 2003 at 02:26:40AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 02:26:40AM -0400, Ben Collins wrote:
> This was causing me all sorts of problems with linux1394's 16-18 byte
> long bus_id lengths. The sysfs names were all broken.
> 
> This not only makes KOBJ_NAME_LEN match BUS_ID_SIZE, but fixes the
> strncpy's in drivers/base/ so that it can't happen again (atleast the
> strings will be null terminated).

What about defining BUS_ID_SIZE in terms of KOBJ_NAME_LEN?

