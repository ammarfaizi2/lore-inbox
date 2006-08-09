Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWHIB1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWHIB1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWHIB1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:27:54 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:54405 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030397AbWHIB1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:27:53 -0400
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Mannthey <kmannth@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, apw@shadowen.org
In-Reply-To: <a762e240608081710h532f6bbl7a1670537fd481bd@mail.gmail.com>
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0608061829430.20012@blonde.wat.veritas.com>
	 <m13bc8b6ca.fsf@ebiederm.dsl.xmission.com>
	 <a762e240608081710h532f6bbl7a1670537fd481bd@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 11:27:51 +1000
Message-Id: <1155086871.26428.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 17:10 -0700, Keith Mannthey wrote:
> The parameter hotadd_percent is setup right but there is a
> "Malformed early option 'numa'" message.

For the record: this happens when the function registered with
early_param() returns non-zero.  __setup() functions return 1 if OK,
module_param() and early_param() return 0 or a -ve error code.

Hope that clarifies,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

