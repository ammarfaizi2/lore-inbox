Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVCIAjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVCIAjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVCIAg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:36:29 -0500
Received: from isilmar.linta.de ([213.239.214.66]:62427 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262408AbVCHXqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:46:12 -0500
Date: Wed, 9 Mar 2005 00:46:07 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       jt@hpl.hp.com, linux-pcmcia@lists.infradead.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA product id strings -> hashes generation at compilation time? [Was: Re: [patch 14/38] pcmcia: id_table for wavelan_cs]
Message-ID: <20050308234607.GA21231@isilmar.linta.de>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	jt@hpl.hp.com, linux-pcmcia@lists.infradead.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050308123426.249fa934.akpm@osdl.org> <20050227161308.GO7351@dominikbrodowski.de> <20050307225355.GB30371@bougret.hpl.hp.com> <20050307230102.GA29779@isilmar.linta.de> <20050307150957.0456dd75.akpm@osdl.org> <20050307232339.GA30057@isilmar.linta.de> <20050308191138.GA16169@isilmar.linta.de> <Pine.LNX.4.58.0503081438040.13251@ppc970.osdl.org> <20050308231636.GA20658@isilmar.linta.de> <20050308233706.GA11454@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308233706.GA11454@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 03:37:07PM -0800, Greg KH wrote:
> module aliases, and fixing up modprobe to handle spaces in module
> aliases wouldn't work out easier.

spaces _and_ characters. And characters are already used to separate 
different fields. 

pcmcia:pa"some string"pb"some other string"

doesn't look bad though, indeed. Problem is: how to access the strings in 
file2alias.c? They're in different sections than the __mod_devicetables, and
you'd need to get architecture-dependant relocation... so this doesn't seem 
feasible... or am I missing something?

	Dominik
