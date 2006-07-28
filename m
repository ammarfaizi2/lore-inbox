Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161229AbWG1Soo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbWG1Soo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWG1Soo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:44:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46274 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161229AbWG1Son (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:44:43 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 5/5] Add the -fstack-protector option to the CFLAGS
Date: Fri, 28 Jul 2006 20:45:05 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <1154102736.6416.19.camel@laptopd505.fenrus.org>
In-Reply-To: <1154102736.6416.19.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282045.05292.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +ifdef CONFIG_CC_STACKPROTECTOR
> +CFLAGS += $(call cc-ifversion, -lt, 0402, -fno-stack-protector)
> +CFLAGS += $(call cc-ifversion, -ge, 0402, -fstack-protector)

Why can't you just use the normal call cc-option for this?

-Andi
