Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUFLDPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUFLDPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 23:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264596AbUFLDPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 23:15:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:58269 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264595AbUFLDPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 23:15:25 -0400
Date: Fri, 11 Jun 2004 20:15:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: In-kernel Authentication Tokens (PAGs)
Message-ID: <20040611201523.X22989@build.pdx.osdl.net>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com>; from mrmacman_g4@mac.com on Fri, Jun 11, 2004 at 10:37:36PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett (mrmacman_g4@mac.com) wrote:
> I am working on a generic PAG subsystem for the kernel, something that
> handles BLOB PAG data and could be used for OpenAFS, Coda, NFSv4, etc.
> I have a patch, but it is not well tested yet.  Here is an overview of 
> the
> architecture:
> 
> Each process has a PAG, and each PAG has a parent PAG.  Users are
> allowed to make new PAGs associated with their UID and modify ones that
> are already associated with their UID.  Each PAG consists of a set of 

Hrm.  Wouldn't it be possible that two processes with same uid have
authenticated in different domains, and as such shouldn't be allowed to
touch each other's PAGs?  Or is this not allowed?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
