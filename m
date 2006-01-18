Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWARSgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWARSgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWARSgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:36:40 -0500
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:62105 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030250AbWARSgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:36:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=cZE2FZ+wxMEyY25iETGWx8hC38qYIt6rI1F8b6PqewMTite7xFl4dU5h7IP/ga4ichf4EhgS0frvErqMdiSEshnRWFilqArtay/YjtTQdVApvhdzykVeSz4rft5ZhbWDRN1tY+tBopQV5HNr+vT7S2EQMKah1YRuXud2TcWPIhs=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
Date: Wed, 18 Jan 2006 19:36:26 +0100
User-Agent: KMail/1.8.3
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <20060118011200.GA28086@kroah.com> <200601181253.54942.blaisorblade@yahoo.it> <20060118170212.GB12757@kroah.com>
In-Reply-To: <20060118170212.GB12757@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601181936.26614.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 18:02, Greg KH wrote:
> On Wed, Jan 18, 2006 at 12:53:54PM +0100, Blaisorblade wrote:

> As for your specific bug report, sorry, I really don't know.

I know it's not something easy to find, but nor me nor Jeff master deeply the 
kobject API. And we're not short of work.

Is there anybody who while reviewing various drivers could review our ones on 
this aspect (the same way people like you use to review and fix bugs all over 
the tree)?

I know this may seem unkind, but it's a "specialization thing" - 
don't let an engineer heal somebody nor a doctor build a house, and don't 
request them doing such things - defer the thing to more competent people, if 
possible.

Alternatively, documentation is accepted. Is LDD v3 up-to-date enough? Guess 
not.

A question: looking at ide driver I saw that they don't use the 
platform_device API, because they're already in the block category.

Could we be causing trouble by using both block API (with gendisk stuff) and 
platform_device? Can platform_device

Alternatively, is drivers/input/serio/i8042.c a likely correct API example?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
