Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269032AbUICPnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269032AbUICPnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUICPnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:43:49 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:3479 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S269032AbUICPnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:43:46 -0400
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
       umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41386FB7.2060804@cs.aau.dk>
References: <41385FA5.806@cs.aau.dk> <20040903133238.A4145@infradead.org>
	 <413865B4.7080208@cs.aau.dk> <20040903140449.A4253@infradead.org>
	 <41386FB7.2060804@cs.aau.dk>
Content-Type: text/plain; charset=UTF-8
Organization: National Security Agency
Message-Id: <1094225934.19206.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 11:38:54 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 09:20, Kristian Sørensen wrote:
> E.g. if a root owned process is restricted from accessing /var/www, and 
> the process is compromised by an attacker, no mater what he does, he 
> would not be able to access this directory.

Control access to objects, not names.  Assign security attributes to the
objects, and use those attributes in your access control checks, not a
useless pathname.  Otherwise, your "security" system will always be
trivially bypassable.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

