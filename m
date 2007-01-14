Return-Path: <linux-kernel-owner+w=401wt.eu-S1751463AbXANSuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbXANSuK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 13:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXANSuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 13:50:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53038 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbXANSuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 13:50:09 -0500
Subject: Re: Shrink the held_lock struct by using bitfields.
From: Ingo Molnar <mingo@redhat.com>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <20070102233824.GF18033@redhat.com>
References: <20070102233558.GA4577@redhat.com>
	 <20070102233824.GF18033@redhat.com>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 19:45:50 +0100
Message-Id: <1168800350.32239.13.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 18:38 -0500, Dave Jones wrote:
> +       unsigned char irq_context:1;
> +       unsigned char trylock:1;
> +       unsigned char read:2;
> +       unsigned char check:1;
> +       unsigned char hardirqs_off:1; 

cool! I totally missed those. I'd even do this for 2.6.20, but it's
probably too late for that.

Acked-by: Ingo Molnar <mingo@redhat.com>

	Ingo

