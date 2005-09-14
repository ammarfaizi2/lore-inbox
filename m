Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbVINJeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbVINJeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbVINJeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:34:36 -0400
Received: from ns.firmix.at ([62.141.48.66]:36077 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S965117AbVINJeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:34:36 -0400
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
From: Bernd Petrovitsch <bernd@firmix.at>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi,
       jirislaby@gmail.com, lion.vollnhals@web.de
In-Reply-To: <20050913162851.7467b52d.pj@sgi.com>
References: <200509130010.38483.lion.vollnhals@web.de>
	 <43260817.7070907@gmail.com> <84144f0205091221431827b126@mail.gmail.com>
	 <200509130033.11109.dtor_core@ameritech.net>
	 <20050912234200.10b2abe7.akpm@osdl.org>
	 <20050913162851.7467b52d.pj@sgi.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 14 Sep 2005 11:33:53 +0200
Message-Id: <1126690433.11423.9.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 16:28 -0700, Paul Jackson wrote:
> Andrew wrote:
> > It hurts readability.  Quick question: is this code correct?
> > 
> > 	dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
> 
> And it hurts maintainability.  If someone changes 'dev' so
> that it is no longer of type 'struct net_device', then they
                                'struct net_device *'
> risk missing this allocation, and introducing what could be
> a nasty memory corruption kernel bug.

SCNR,
	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

