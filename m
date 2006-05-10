Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWEJKYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWEJKYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWEJKYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:24:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62686 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964890AbWEJKYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:24:05 -0400
Subject: Re: [PATCH -mm] riva CalcStateExt gcc 4.1 warning fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <200605100256.k4A2u56F031749@dwalker1.mvista.com>
References: <200605100256.k4A2u56F031749@dwalker1.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 May 2006 11:35:43 +0100
Message-Id: <1147257343.17886.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 19:56 -0700, Daniel Walker wrote:
> This could be a bug. The return from CalcVClock isn't checked
> so the variables in questions could be random data ..
> 
> Fixes the following warning,
> 
> drivers/video/riva/riva_hw.c: In function 'CalcStateExt':
> drivers/video/riva/riva_hw.c:1241: warning: 'p' may be used uninitialized in this function
> drivers/video/riva/riva_hw.c:1241: warning: 'n' may be used uninitialized in this function
> drivers/video/riva/riva_hw.c:1241: warning: 'm' may be used uninitialized in this function
> drivers/video/riva/riva_hw.c:1241: warning: 'VClk' may be used uninitialized in this function

But zero isn't valid data. You need to fix the missing return check not
hide the warnings. This goes for just about every patch in this series

