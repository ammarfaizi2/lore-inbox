Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423846AbWKIOyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423846AbWKIOyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423854AbWKIOyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:54:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11465 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423846AbWKIOyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:54:12 -0500
Subject: Re: Abysmal PATA IDE performance
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen.Clark@seclark.us
Cc: "\"\\\"J.A.\\\"" =?ISO-8859-1?Q?Magall=F3n=22?= 
	<jamagallon@ono.com>,
       =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Mark Lord <lkml@rtr.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <45533DB9.4000405@seclark.us>
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca>
	 <455277E1.3040803@seclark.us> <20061109020758.GA21537@atjola.homenet>
	 <4552A638.4010207@seclark.us>  <20061109094014.1c8b6bed@werewolf-wl>
	 <1163062700.3138.467.camel@laptopd505.fenrus.org>
	 <45533DB9.4000405@seclark.us>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 09 Nov 2006 15:54:05 +0100
Message-Id: <1163084045.3138.502.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> >  
> >
> Thanks all.
> 
> Arjan, using combined_mode=libata and making a new ramdisk increased my 
> xfer rate from 1.xx mb/sec to 28.xx mb/sec.
> 

ok that's getting somewhere

> I am curious as to why my friends dell inspiron 8200 with a 1.8ghz p4 
> and the same drive using the same drive with FC6 and the standard ide 
> module gets 44 to 45 mb/sec.

now it is going to come down to how you measure this....

don't use hdparm, use something like tiobench (tiobench.sf.net);
another setting that might be different is that scsi normally turns the
write back cache off (safer for your data but slower) while IDE normally
leaves at at factory default (on for cheating on benchmarks).
For writes, this can easily explain the difference...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

