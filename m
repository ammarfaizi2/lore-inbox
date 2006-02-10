Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWBJRdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWBJRdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWBJRdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:33:43 -0500
Received: from animx.eu.org ([216.98.75.249]:64170 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1751322AbWBJRdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:33:43 -0500
Date: Fri, 10 Feb 2006 12:36:57 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Imre Gergely <imre.gergely@astral.ro>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: disabling libata
Message-ID: <20060210173657.GB29028@animx.eu.org>
Mail-Followup-To: Imre Gergely <imre.gergely@astral.ro>,
	Erik Mouw <erik@harddisk-recovery.com>,
	linux-kernel@vger.kernel.org
References: <43EC97C6.10607@astral.ro> <20060210141130.GE28676@harddisk-recovery.com> <43ECA035.5040302@astral.ro> <20060210142224.GF28676@harddisk-recovery.com> <43ECB91E.6060109@astral.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ECB91E.6060109@astral.ro>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Imre Gergely wrote:
> 
> 
> Erik Mouw wrote:
> > Yes, I know that's possible for some SATA adapters, but my question is
> > why would you want to do that? The SATA support in the IDE subsystem is
> > deprecated, you should really use libata.
> > 
> > 
> > Erik
> > 
> 
> maybe it's just me... but it looks like if as SCSI device the whole thing is
> slower than with IDE. i haven't tested it yet, but as sda the system load is
> very high, i did some tests with dd, and the CPU usage is always at 98-100%.
> and when i'm copying something to another disk, the other programs barely move,
> sometimes even the mouse gets stuck. i dunno where this is coming from. i
> thought i try with the old driver.

I asked this same question with U320 scsi controller.  I noticed my CPU went
to 100%.  It never really was being used at all, just in wait.  Run top to
see if "wa" is high or not.

This is what I see (no load, no disk activity) for the CPU:
Cpu(s):  0.1% us,  0.1% sy,  0.0% ni, 97.6% id,  2.2% wa,  0.0% hi,  0.1% si

Copying a single disk to /dev/null (9.1gb):
Cpu(s):  0.0% us,  1.7% sy,  0.0% ni, 74.8% id, 23.3% wa,  0.0% hi,  0.2% si

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
