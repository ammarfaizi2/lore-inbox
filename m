Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTKBMwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 07:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTKBMwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 07:52:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8462 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261683AbTKBMwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 07:52:39 -0500
Date: Sun, 2 Nov 2003 12:52:03 +0000
From: Dave Jones <davej@redhat.com>
To: Geoffrey Lee <glee@gnupilgrims.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] reproducible athlon mce fix
Message-ID: <20031102125202.GA7992@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Geoffrey Lee <glee@gnupilgrims.org>, linux-kernel@vger.kernel.org
References: <20031102055748.GA1218@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102055748.GA1218@anakin.wychk.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 01:57:48PM +0800, Geoffrey Lee wrote:

 >  	preempt_disable(); 
 > +#if CONFIG_MK7
 > +	for (i=1; i<nr_mce_banks; i++) {
 > +#else
 >  	for (i=0; i<nr_mce_banks; i++) {
 > +#endif
 >  		rdmsr (MSR_IA32_MC0_STATUS+i*4, low, high);

This needs to be a runtime check. In 2.6, a K7 can boot
a P4 kernel, and vice versa.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
