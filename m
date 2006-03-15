Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWCOKXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWCOKXR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWCOKXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:23:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57570 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751472AbWCOKXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:23:17 -0500
Subject: Re: [Patch 1/9] timestamp diff
From: Arjan van de Ven <arjan@infradead.org>
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1142296939.5858.6.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142296939.5858.6.camel@elinux04.optonline.net>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 11:23:13 +0100
Message-Id: <1142418194.3021.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +static inline void timespec_diff(struct timespec *start, struct timespec *end,
> +				 struct timespec *ret)
> +{
> +	ret->tv_sec = end->tv_sec - start->tv_sec;
> +	ret->tv_nsec = end->tv_nsec - start->tv_nsec;
> +}
>  #endif /* __KERNEL__ */

I'd suggest normalizing the timespec; better to do it in such a function
than in all callers of it..


