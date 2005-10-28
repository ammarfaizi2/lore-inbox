Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbVJ1JTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbVJ1JTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbVJ1JTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:19:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13208 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965199AbVJ1JTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:19:23 -0400
Subject: Re: [PATCH] Process Events Connector
From: Arjan van de Ven <arjan@infradead.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Jay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>
In-Reply-To: <1130489713.10680.685.camel@stark>
References: <1130489713.10680.685.camel@stark>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 11:19:06 +0200
Message-Id: <1130491147.2800.15.camel@laptopd505.fenrus.org>
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

On Fri, 2005-10-28 at 01:55 -0700, Matt Helsley wrote:

> +void proc_fork_connector(struct task_struct *task)
> +{
> +	struct cn_msg *msg;
> +	struct proc_event *ev;
> +	__u8 buffer[CN_PROC_MSG_SIZE];

do you really want to do this stack based?



