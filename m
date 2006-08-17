Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWHQXen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWHQXen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWHQXen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:34:43 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:45704 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030376AbWHQXem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:34:42 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 13/13] IB/ehca: makefiles/kconfig
Date: Fri, 18 Aug 2006 01:34:37 +0200
User-Agent: KMail/1.9.1
Cc: Roland Dreier <rolandd@cisco.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
References: <20068171311.WDFBWw0F6z9B3Qes@cisco.com>
In-Reply-To: <20068171311.WDFBWw0F6z9B3Qes@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608180134.39050.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 22:11, Roland Dreier wrote:
> +
> +CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL

This seems really pointless, since you're always defining these
macros to the same value.

Just drop the CFLAGS and remove the code that depends on them
being different.

	Arnd <><
