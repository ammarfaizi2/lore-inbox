Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272566AbTHSRtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272333AbTHSRrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:47:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:2003 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272314AbTHSRmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:42:09 -0400
Date: Tue, 19 Aug 2003 10:42:08 -0700
From: Greg KH <greg@kroah.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA bus update
Message-ID: <20030819174208.GA4992@kroah.com>
References: <wrp3cfxn78n.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrp3cfxn78n.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 02:48:24PM +0200, Marc Zyngier wrote:
> +static void virtual_eisa_release (struct device *dev)
> +{
> +	/* nothing really to do here */
> +}

Um, no.  That's not correct.  Don't just paper over valid warning
messages in the kernel by adding functions that do not do anything.

Marc, why do you think that you do not need to do anything in this
function?  Don't you need to handle the fact that your code could be
removed before the release function is called?

Linus, please do not apply this just yet.

thanks,

greg k-h
