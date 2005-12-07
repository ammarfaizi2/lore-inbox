Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbVLGM1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVLGM1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVLGM1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:27:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17103 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750928AbVLGM1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:27:37 -0500
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
	spin lock to atomic_t.
From: Arjan van de Ven <arjan@infradead.org>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com, gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20051207102419.1f395664.lcapitulino@mandriva.com.br>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
	 <20051206194041.GA22890@suse.de> <20051206201340.GB20451@duckman.conectiva>
	 <200512062348.14349.oliver@neukum.org>
	 <20051207102419.1f395664.lcapitulino@mandriva.com.br>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 13:27:13 +0100
Message-Id: <1133958433.2869.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  Isn't it right? Is the URB write so fast that switching to atomic_t
> doesn't pay-off?

an atomic_t access and a spinlock are basically the same price... so
what's the payoff ?


