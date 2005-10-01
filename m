Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVJAJf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVJAJf1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 05:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVJAJf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 05:35:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29656 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750779AbVJAJf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 05:35:26 -0400
Subject: RE: RH30: Virtual Mem shot heavily by locale-archive...
From: Arjan van de Ven <arjan@infradead.org>
To: Arijit Das <Arijit.Das@synopsys.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE916831E@IN01WEMBX1.internal.synopsys.com>
References: <7EC22963812B4F40AE780CF2F140AFE916831E@IN01WEMBX1.internal.synopsys.com>
Content-Type: text/plain
Date: Sat, 01 Oct 2005 11:35:15 +0200
Message-Id: <1128159315.2916.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-01 at 14:49 +0530, Arijit Das wrote:
> Shared mappings are represented in /proc/<pid>/maps file as having 's'
> as its last permission field like r-xs (shared readable and executable
> region)
> 
> But in this case, the perm bits are r--p which says that it is private
> rather than shared. Any idea whatz happening here...?

what is the problem??????
private mappings don't take up "extra" memory *unless you write to them*
due to copy-on-write behavior of the kernel. r--p means you can't
write.... so what's the problem..

