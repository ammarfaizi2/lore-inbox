Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTJHT5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 15:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTJHT5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 15:57:30 -0400
Received: from yakov.inr.ac.ru ([193.233.7.111]:18862 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S261773AbTJHT53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 15:57:29 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200310081957.XAA01425@yakov.inr.ac.ru>
Subject: Re: NAPI Race?
To: marko@pacujo.net (Marko Rauhamaa)
Date: Wed, 8 Oct 2003 23:57:14 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org, hadi@cyberus.ca (Jamal Hadi Salim),
       Robert.Olsson@data.slu.se (Robert Olsson)
In-Reply-To: <m3smm4qvf0.fsf@lumo.pacujo.net> from "Marko Rauhamaa" at Oct 07, 2003 08:07:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> interrupted for some other reason, the packet will get processed only at
> the next jiffie when the soft irq is invoked again.
> 
> Am I mistaken?

Yes, you are wrong. It is processed as soon as possible.


> As an aside, it looks also as though the design might technically allow
> the network driver to starve the CPU (the very situation NAPI was
> designed to protect against).

Nope. NAPI is not expected to cure starvation caused by softirqs.

Alexey
