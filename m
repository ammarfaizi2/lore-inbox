Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUFVXdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUFVXdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbUFVXdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:33:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:19437 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264500AbUFVXdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:33:07 -0400
Date: Tue, 22 Jun 2004 16:23:01 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix MSI-X setup
Message-ID: <20040622232301.GB13197@kroah.com>
References: <52lligqqlc.fsf@topspin.com> <521xk8qlx1.fsf@topspin.com> <52smcop5v7.fsf_-_@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52smcop5v7.fsf_-_@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 09:35:24PM -0700, Roland Dreier wrote:
> msix_capability_init() puts the offset of the MSI-X capability into
> pos, then uses pos as a loop index to clear the MSI-X vector table,
> and then tries to use pos as the offset again, which results in
> writing the MSI-X enable bit off into space.
> 
> This patch fixes that by adding a new loop index variable and using
> that to clear the vector table.
> 
>  - Roland
> 
> Signed-off-by: Roland Dreier <roland@tospin.com>

Applied, thanks.

greg k-h
