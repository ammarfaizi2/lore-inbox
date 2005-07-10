Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVGJMhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVGJMhM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 08:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVGJMhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 08:37:12 -0400
Received: from animx.eu.org ([216.98.75.249]:21935 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261924AbVGJMhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 08:37:07 -0400
Date: Sun, 10 Jul 2005 08:54:38 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
Message-ID: <20050710125438.GA17784@animx.eu.org>
Mail-Followup-To: Bernd Eckenfels <ecki@lina.inka.de>,
	linux-kernel@vger.kernel.org
References: <20050710014559.GA15844@animx.eu.org> <E1DrRLL-00017G-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DrRLL-00017G-00@calista.eckenfels.6bone.ka-ip.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <20050710014559.GA15844@animx.eu.org> you wrote:
> > You misunderstood entirely what I said.
> 
> There is no portable/documented way to grow a file without having the file
> system null its content. However why is that a problem, you dont create
> those files very often. Besides it is better for the OS to be able to asume
> that a page with zeros in it is equal to the page on fresh swap.

So are you saying that if I create a swap partition it's best to use dd to
zero it out before mkswap?  If no, then why would a file be different?  I
know there's no documented way to create a file of given size without
writing content.  I saw windows grow a pagefile several meg in less than a
second so I'm sure that it doesn't zero out the space first.

As far as portable, we're talking about linux, portability is not an issue
in this case.  I myself don't use swap files (or partitions), however, there
was a project I recall that would dynamically add/remove swap as needed. 
Creating a file of 20-50mb quickly would have been beneficial.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
