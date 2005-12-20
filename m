Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVLTSFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVLTSFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVLTSFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:05:14 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:40638 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750805AbVLTSFN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:05:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A1y23hmvYF0G0XS4wQiYSCq8zi60oDTxzEav7etanp/orcIOfrmjq5qmawXV4wyH7TYya5Ftdmk/vCQvm7P62f18HIK652W2eqWW9vVc40b4a7houriE/2qPEPMpPXQg6Fu0AFXbvJlRewSCDNwG3VfAupJqBJkio5VyIUDI3dY=
Message-ID: <12c511ca0512201005k4d499b57v724815258f80322@mail.gmail.com>
Date: Tue, 20 Dec 2005 10:05:11 -0800
From: Tony Luck <tony.luck@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: quick overview of the perfmon2 interface
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
In-Reply-To: <20051220025156.a86b418f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051219113140.GC2690@frankl.hpl.hp.com>
	 <20051220025156.a86b418f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >       The interface also supports automatic randomization of the reset value
> >       for a PMD after an overflow.
>
> Why would one want to randomise the PMD after an overflow?

To get better data.  Using a constant reload value may keep measuring the
same spot in the application if you are using a sample frequency that
matches some repeat pattern in the application (and Murphy's law says
that you'll hit this a lot).

-Tony
