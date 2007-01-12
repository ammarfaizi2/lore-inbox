Return-Path: <linux-kernel-owner+w=401wt.eu-S1030450AbXALCq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbXALCq6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 21:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbXALCq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 21:46:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:31743 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030450AbXALCq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 21:46:58 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EB595ixS+Ll25A9oLHbdW/nYn8ZGiZMSmH9j7PxFe4EvWqkeJxu8oj4gwSkHb4ASecvhUKFQbi7fvaAXqpzu94RvJhYOqaHKwJ5VLxcpG+PL6vP+xSI+ep/R8wOQzYORKmBP6SoabkkAhIrpdTkIDxpa8jbeGAge2vNyQyY/Y7g=
Message-ID: <4df04b840701111846j747a387fj73e1739c83bd3335@mail.gmail.com>
Date: Fri, 12 Jan 2007 10:46:55 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: "Rik van Riel" <riel@redhat.com>
Subject: Re: [PATCH 2.6.16.29 1/1] MM: enhance Linux swap subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4df04b840701110011p153c6d14t8d5f0ca584af9516@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840701101935i2083da21t26785bc6c00057a7@mail.gmail.com>
	 <45A5DE7C.3030108@redhat.com>
	 <4df04b840701110011p153c6d14t8d5f0ca584af9516@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2007/1/11, yunfeng zhang <zyf.zeroos@gmail.com>:
2007/1/11, Rik van Riel <riel@redhat.com>:
>
> Have you actually measured this?
>
> If your measurements saw any performance gains, with what kind
> of workload did they happen, how big were they and how do you
> explain those performance gains?
>
> How do you balance scanning the private memory with taking
> pages off the per-zone page lists?
>
> How do you deal with systems where some zones are really
> large and other zones are really small, eg. a 32 bit system
> with one 880MB zone and one 15.1GB zone?
>

Another solution is add a new field preferred_zone to the scan_control of
mm/vmscan.c, keep it in mind that new swap strategy is from up to down, from
UserSpace to PrivatePage/SharedPage.
