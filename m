Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVIDUXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVIDUXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 16:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIDUXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 16:23:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20103 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751085AbVIDUXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 16:23:38 -0400
Date: Sun, 4 Sep 2005 16:23:33 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: hyoshiok@miraclelinux.com, mm-commits@vger.kernel.org
Subject: Re: x86-cache-pollution-aware-__copy_from_user_ll.patch added to -mm tree
Message-ID: <20050904202333.GA4715@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, hyoshiok@miraclelinux.com,
	mm-commits@vger.kernel.org
References: <200509042017.j84KHekQ032373@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509042017.j84KHekQ032373@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 01:16:00PM -0700, Andrew Morton wrote:
 >  unsigned long __copy_to_user_ll(void __user *to, const void *from, unsigned long n)
 >  {
 >  	BUG_ON((long) n < 0);

Ehh? It's unsigned. This will never be true.

 > +unsigned long
 > +__copy_from_user_ll_nocache(void *to, const void __user *from, unsigned long n)
 > +{
 > +	BUG_ON((long)n < 0);

Ditto.

		Dave

