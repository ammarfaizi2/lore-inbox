Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVBXPt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVBXPt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVBXPtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:49:01 -0500
Received: from mail.autoweb.net ([198.172.237.26]:45836 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262381AbVBXPr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:47:56 -0500
Date: Thu, 24 Feb 2005 10:47:05 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
       elsa-devel@lists.sourceforge.net, jlan@engr.sgi.com, gh@us.ibm.com,
       efocht@hpce.nec.com
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
Message-ID: <20050224154704.GC7828@mythryan2.michonline.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
	linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
	elsa-devel@lists.sourceforge.net, jlan@engr.sgi.com, gh@us.ibm.com,
	efocht@hpce.nec.com
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr> <20050224024605.76e7369f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224024605.76e7369f.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 02:46:05AM -0800, Andrew Morton wrote:
> Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> 
> >  +spinlock_t fork_cn_lock = SPIN_LOCK_UNLOCKED;
> 
> This should have static scope, and could be local to fork_connector().
> 
> Please use DEFINE_SPINLOCK().  (There's a reason for this, but I forget
> what it was).

Static analysis tools, IIRC. (Stanford checker, sparse)


-- 

Ryan Anderson
  sometimes Pug Majere
