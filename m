Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbUCIXdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbUCIXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:31:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:7593 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262462AbUCIX2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:28:04 -0500
Date: Tue, 9 Mar 2004 15:02:36 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix i2c_use_client()
Message-ID: <20040309230236.GB13763@kroah.com>
References: <20040307161341.A7065@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040307161341.A7065@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 04:13:41PM +0000, Russell King wrote:
> i2c_use_client() contains a bogosity.  If i2c_inc_use_client() returns
> success, i2c_use_client() returns an error.  If i2c_inc_use_client()
> fails, i2c_use_client() might succeed.
> 
> Fix it so that (a) we get the correct sense between these two functions,
> and (b) propagate the error code from i2c_inc_use_client(), rather than
> making our own one up.

Nice, thanks.  I've applied this.

greg k-h
