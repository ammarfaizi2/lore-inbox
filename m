Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWCVIin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWCVIin (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCVIin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:38:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42151 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751101AbWCVIim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:38:42 -0500
Subject: Re: [RFC PATCH 25/35] Add Xen time abstractions
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060322063800.241815000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063800.241815000@sorel.sous-sol.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 09:38:40 +0100
Message-Id: <1143016720.2955.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  # We must build both images before we can assemble it.
> --- /dev/null
> +++ xen-subarch-2.6/arch/i386/mach-xen/time.c
> @@ -0,0 +1,1045 @@
> +/*
> + *  linux/arch/i386/kernel/time.c

no it's not



is there any reason why this is a full copy rather than just a
subarching of the modified functions, or some simple hooks into the
generic function?

Duplication like this is evil because it means too many places need
duplicated bugfixes and rework (and such rework is underway)

