Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVAYVTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVAYVTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVAYVQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:16:09 -0500
Received: from waste.org ([216.27.176.166]:14729 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262142AbVAYVOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:14:25 -0500
Date: Tue, 25 Jan 2005 13:14:01 -0800
From: Matt Mackall <mpm@selenic.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/12] random pt4: Replace SHA with faster version
Message-ID: <20050125211401.GO12076@waste.org>
References: <7.314297600@selenic.com> <200501252307.21993.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501252307.21993.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:07:21PM +0200, Denis Vlasenko wrote:
> On Friday 21 January 2005 23:41, Matt Mackall wrote:
> > - * @W:      80 words of workspace
> > + * @W:      80 words of workspace, caller should clear
> 
> Why?

Are you asking why should the caller clear or why should it be cleared at all?

For the first question, having the caller do the clear avoids
redundant clears on repeated calls.

For the second question, forward security. If an attacker breaks into
the box shortly after a secret is generated, he may be able to recover
the secret from such state.

-- 
Mathematics is the supreme nostalgia of our time.
