Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVFICJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVFICJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 22:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVFICJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 22:09:07 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:57321 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261522AbVFICJB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 22:09:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=So1Mbm6b5iC2dkSYYLse3BOK8OHStEgAN2xui+sE7dVN44iPQK0e4uEHkoPKT2EK+P5nRyuN7qAG2o+zdLcNxrYBBo0j3mLnghrEM/XPBEK5RLZ7V2S2mwlUkHohtjfg15JH5+fUOxeQ6Px+avCAUSLygoRJhi6qs/JcpLw8G5A=
Message-ID: <9e4733910506081909560e368c@mail.gmail.com>
Date: Wed, 8 Jun 2005 22:09:01 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Dell BIOS and HPET timer support
Cc: Lee Revell <rlrevell@joe-job.com>, lkml <linux-kernel@vger.kernel.org>,
       Bob Picco <Robert.Picco@hp.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6004EF3629@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88056F38E9E48644A0F562A38C64FB6004EF3629@scsmsx403.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
> 
> 
> I think do_div expects a 64 bit 1st argument. Can you change ns to
> unsigneld long long and try...

I already posted a patch. The field is 32 bits so a long is correct.
The do_div() is just wrong, it should have been /.

-- 
Jon Smirl
jonsmirl@gmail.com
