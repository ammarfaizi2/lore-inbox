Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTIWMqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 08:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTIWMqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 08:46:33 -0400
Received: from nevyn.them.org ([66.93.172.17]:12760 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263355AbTIWMqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 08:46:32 -0400
Date: Tue, 23 Sep 2003 08:46:28 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923124627.GA3052@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030922194833.GA2732@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922194833.GA2732@velociraptor.random>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 09:48:33PM +0200, Andrea Arcangeli wrote:
> +#if !defined(CONFIG_LOG_BUF_SHIFT) || (CONFIG_LOG_BUF_SHIFT - 0 == 0)

It shouldn't have an empty string value anyway, so this is just:
#if !CONFIG_LOG_BUF_SHIFT

That handles both !defined and !0.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
