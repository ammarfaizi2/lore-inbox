Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWF1ThF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWF1ThF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWF1ThF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:37:05 -0400
Received: from smtp-out.google.com ([216.239.45.12]:29783 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751095AbWF1ThB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:37:01 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=IdvGfIEbuPwn5XjCI27VIKR6edR2tLQsohA+BX7ZaOcJAePxbeDUT9An/VTwHlt33
	lxZkoPzt9XVxyAvQDDItg==
Message-ID: <44A2DA40.40502@google.com>
Date: Wed, 28 Jun 2006 12:36:32 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mbligh@mbligh.org, jeremy@goop.org, linux-kernel@vger.kernel.org,
       apw@shadowen.org, linuxppc64-dev@ozlabs.org, drfickle@us.ibm.com
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>	<449FF3A2.8010907@mbligh.org>	<44A150C9.7020809@mbligh.org>	<20060628034215.c3008299.akpm@osdl.org>	<20060628034748.018eecac.akpm@osdl.org>	<44A29582.7050403@google.com> <20060628121102.638f08d9.akpm@osdl.org>
In-Reply-To: <20060628121102.638f08d9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>How the hell did you figure that one out?
> 
> Found a way to reproduce it - do `cat /proc/slabinfo > /dev/null' in a
> tight loop.  With that happening, a little two-way wasn't able to make
> it through `dbench 4' without soiling the upholstery.  Then bisection-searching.

Aha. we probably trigger it because the automated test harness dumps a
bunch of crap out of /proc before and after running dbench then ;-)

Thanks!

M.
