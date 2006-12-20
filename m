Return-Path: <linux-kernel-owner+w=401wt.eu-S964959AbWLTJjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWLTJjY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWLTJjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:39:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43609 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964959AbWLTJjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:39:23 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrei Popa <andrei.popa@i-neo.ro>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <1166605296.10372.191.camel@twins>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 10:39:14 +0100
Message-Id: <1166607554.3365.1354.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmm, should we not flush after clearing the dirty bit? That is, why does
> ptep_clear_flush_dirty() need a flush after clearing that bit? does it
> leak through in the tlb copy?

afaics you need to 
1) clear
2) flush 
3) check and go to 1) if needed

to be race free. 



