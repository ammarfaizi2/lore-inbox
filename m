Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWEEL5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWEEL5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 07:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWEEL5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 07:57:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15838 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751537AbWEEL5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 07:57:14 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 07/13] powerpc: export symbols for page size selection
Date: Fri, 5 May 2006 11:12:33 +0200
User-Agent: KMail/1.9.1
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <20060429232812.825714000@localhost.localdomain> <20060429233921.099214000@localhost.localdomain> <17498.59681.133131.336680@cargo.ozlabs.ibm.com>
In-Reply-To: <17498.59681.133131.336680@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200605051112.34413.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 May 2006 07:56, Paul Mackerras wrote:
> I don't like exporting low-level implementation details like this, and
> it seems a bit bogus to have an SLB miss handler in a module.  Could
> you move the SLB miss handler to the non-modular part?

Yes. The series already has the patches to move the SLB miss handler
into the built-in parts. At the moment, we also need the symbols for
the context switch code that also touches the SLB entries. We already
have a patch to move that as well, but are still discussing the details
of that.

I'll follow up with a patch to replace this one.

	Arnd <><

