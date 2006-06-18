Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWFRWhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWFRWhN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWFRWhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:37:12 -0400
Received: from animx.eu.org ([216.98.75.249]:34704 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750893AbWFRWhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:37:11 -0400
Date: Sun, 18 Jun 2006 18:39:06 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060618223906.GA30726@animx.eu.org>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618212303.GD4744@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> Hi,
> 
> There's a long-standing issue in init=/bin/sh mode: pressing control-C
> doesn't send a SIGINT to programs running on the console. The incurred
> typical pitfall is if one runs ping without a -c option... no way to
> stop it!
> 
> This is because no session is set up by the kernel, and shells don't
> start sessions on their own, so that no session (hence no controlling
> tty) is set up.
> 
> The attached patch sets such session and controlling tty up, which fixes
> the issue. The unfortunate effect is that init might be killed if one
> presses control-C very fast after its start.

Interesting idea, especially for a boot cd I built.

However, why not only set this if the shell is /bin/sh ?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
