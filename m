Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWCUWgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWCUWgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWCUWgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:36:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751108AbWCUWgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:36:13 -0500
Date: Tue, 21 Mar 2006 14:38:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] compiler warning, kernel 2.6.16
Message-Id: <20060321143830.0635e661.akpm@osdl.org>
In-Reply-To: <44200223.4020404@t-online.de>
References: <44200223.4020404@t-online.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen <Knut_Petersen@t-online.de> wrote:
>
> If CONFIG_SWAP is _not_ set, gcc complains:
> 
> /src/linux-2.6.16-tfix/mm/vmscan.c: In function `remove_mapping':
> /src/linux-2.6.16-tfix/mm/vmscan.c:398: warning: unused variable `swap'
> 

Yes, that's been there for ages.  That code will be eliminated by the
compiler and I tend to think that the ugliness of making the warning go
away exceeds the benefit of stomping a !CONFIG_SWAP compile warning.
