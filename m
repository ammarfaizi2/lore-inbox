Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWEIWp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWEIWp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWEIWp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:45:57 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:62375 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751333AbWEIWp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:45:57 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [RFC PATCH 04/35] Hypervisor interface header files.
Date: Wed, 10 May 2006 00:43:03 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085148.485343000@sous-sol.org>
In-Reply-To: <20060509085148.485343000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605100043.05241.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

first of all: Thanks to the Xen-Team for doing this!

On Tuesday, 9. May 2006 09:00, Chris Wright wrote:
> Define macros and inline functions for doing hypercalls into the
> hypervisor.
> +static inline int
> +HYPERVISOR_set_trap_table(
> +	struct trap_info *table)
> +{
> +	return _hypercall1(int, set_trap_table, table);
> +}

This is outright ugly and non-conformant to 
Documentation/CodingStyle Chapter 2

Fixing this also saves some code lines.

It also looks like generated code. Maybe you can fix your generator
instead?


Regards

Ingo Oeser
