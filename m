Return-Path: <linux-kernel-owner+w=401wt.eu-S1422874AbWLUIyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422874AbWLUIyS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422870AbWLUIyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:54:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60259 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422863AbWLUIyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:54:17 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Arjan van de Ven <arjan@infradead.org>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <4807377b0612201810t66218e4u4089df818129f1ce@mail.gmail.com>
References: <20061219185223.GA13256@srcf.ucam.org>
	 <20061220042648.GA19814@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de>
	 <20061220055209.GA20483@srcf.ucam.org>
	 <1166601025.3365.1345.camel@laptopd505.fenrus.org>
	 <20061220125314.GA24188@srcf.ucam.org>
	 <1166621931.3365.1384.camel@laptopd505.fenrus.org>
	 <20061220143134.GA25462@srcf.ucam.org>
	 <1166629900.3365.1428.camel@laptopd505.fenrus.org>
	 <4807377b0612201810t66218e4u4089df818129f1ce@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 21 Dec 2006 09:54:13 +0100
Message-Id: <1166691253.3365.1480.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there some reason why we can't have the OS just do the D3
> transition for all drivers that register support?  I mean, this power
> management using D states is actually driver *independent* and at
> least way back in the day was supposed to be implemented for "OS power
> management"

all you need to do is 1 function call from your interface down code.. so
it's really not a big deal to just do that call ;)
(well and you want the D0 call in the up code, but that's ok)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

