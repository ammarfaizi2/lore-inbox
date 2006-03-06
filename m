Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWCFNP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWCFNP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWCFNPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:15:55 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:24796 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932214AbWCFNPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:15:54 -0500
Date: Mon, 6 Mar 2006 13:15:41 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATA failure with piix, works with libata
Message-ID: <20060306131540.GA11265@srcf.ucam.org>
References: <20060303183937.GA30840@srcf.ucam.org> <20060305225733.GA8578@srcf.ucam.org> <440B770A.8090707@garzik.org> <20060306003221.GA8805@srcf.ucam.org> <440B8921.9030602@garzik.org> <20060306010333.GA8951@srcf.ucam.org> <440B8B39.8090007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440B8B39.8090007@garzik.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 08:07:05PM -0500, Jeff Garzik wrote:

> Honestly I'm quite surprised that there is a difference between legacy 
> and native mode (more joy :)).  ICH seems to want an ack to the bmdma 
> status register even on non-DMA commands, since it directly reflects the 
> IDE INTRQ line.  Perhaps pounding on the Status register will clear that 
> condition, thus enabling legacy software to continue successfully 
> without worry about this ICH-specific detail.  </speculation>

Yeah, that seems to work. Thanks! I'll see if I can clean this up...
-- 
Matthew Garrett | mjg59@srcf.ucam.org
