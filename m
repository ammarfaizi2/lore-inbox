Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUFCXsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUFCXsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264864AbUFCXsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:48:31 -0400
Received: from holomorphy.com ([207.189.100.168]:60065 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264857AbUFCXsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:48:30 -0400
Date: Thu, 3 Jun 2004 16:48:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: herbert@gondor.apana.org.au, len.brown@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [APIC] Avoid change apic_id failure panic
Message-ID: <20040603234819.GO21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, herbert@gondor.apana.org.au,
	len.brown@intel.com, linux-kernel@vger.kernel.org
References: <20040603101313.GB6578@gondor.apana.org.au> <20040603162045.7a335350.akpm@osdl.org> <20040603233748.GN21007@holomorphy.com> <20040603164415.06a7098c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603164415.06a7098c.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> They're usually not insane. xAPIC's have 8-bit physical ID's, not 4-bit,
>> but no one's bothered tracking whether the APIC's found were serial APIC
>> or xAPIC, and then dispatching on that in the IO-APIC physid check to
>> avoid unnecessarily renumbering the things or panicking.

On Thu, Jun 03, 2004 at 04:44:15PM -0700, Andrew Morton wrote:
> So... what should we do?

In all likelihood, make the thing a variable or return a value based
on the result of GET_APIC_VERSION(), particularly since guessing wrong
either way takes out machines before console_init(). Returning values
based on the result of GET_APIC_VERSION() has a predecent, get_maxlvt().


-- wli
