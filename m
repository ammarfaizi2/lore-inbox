Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWBGGuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWBGGuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 01:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBGGuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 01:50:24 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:65487 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932452AbWBGGuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 01:50:24 -0500
Subject: Re: [RFC PATCH] crc generation fix for EXPORT_SYMBOL_GPL
From: Ram Pai <linuxram@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1139234973.3131.83.camel@laptopd505.fenrus.org>
References: <20060202041543.GA6755@RAM>
	 <1139085087.3131.8.camel@laptopd505.fenrus.org>
	 <1139203471.4641.41.camel@localhost>
	 <1139234973.3131.83.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: IBM 
Date: Mon, 06 Feb 2006 22:49:01 -0800
Message-Id: <1139294941.4723.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 15:09 +0100, Arjan van de Ven wrote:
> > Eventually we want to generate a tool that can report API changes across
> > kernel releases and put it in some friendly(docbook) format.
> 
> the CRC's are only very lightly related to API though (or even ABI) so I
> suspect this isn't too useful a thing to persue in the first place

actually the CRC's capture a pretty good picture of the changes to API
as well as ABI. The crc is run on the prototype of the exported symbol,
recursively expanding each and every datastructure involved in the
prototype. 

Hence it mostly captures the ABI signature of the exported symbols.  The
only part it misses is, it does not capture the GPL'ness of the exported
symbol. And that was what I was trying to fix, because changing the
export nature of the symbol changes the ABI. With the fix one would
be able to exactly detect API/ABI changes to exported symbols. 

Do you think its a bad idea still? Its a good indication for out-of-tree
modules that the ABI/API of some exported symbols they depend on, has
changed.  


>(using CRC I mean, documenting real API changes I can see being useful)

Sure. Nice to learn that this work will be of value. Also
looking for ideas on what information would be useful to report and in
what format. 

Thanks,
RP


> 

