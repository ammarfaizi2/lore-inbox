Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWJMQ6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWJMQ6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWJMQ6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:58:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:54967 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751388AbWJMQ6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:58:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=WJm8as0qIDO420QeUaFS5icySpzFaA5EMdlIWI9OquqavlNf7BrbRCgs3wmq9P3Xx6ystAvLL2/HlD5o50lEeQzzVAOXVATxTeZSiqrxqFLGUkWjP+rV/dYP/IfGpCjU3gXBbjnC0VwSkjay/E7rZFt1pfT1eQIlMqRDhAxOlXQ=
Reply-To: andrew.j.wade@gmail.com
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Can context switches be faster?
Date: Fri, 13 Oct 2006 12:56:42 -0400
User-Agent: KMail/1.9.1
Cc: andrew.j.wade@gmail.com, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org
References: <452E62F8.5010402@comcast.net> <200610122254.10578.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <452F2433.2010307@comcast.net>
In-Reply-To: <452F2433.2010307@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610131258.15451.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 October 2006 01:29, John Richard Moser wrote:
> True.  You can trick the MMU into faulting into the kernel (PaX does
> this to apply non-executable pages-- pages, not halves of VM-- on x86),

Oooh, that is a neat hack!

> but it's orders of magnitude slower as I understand and the petty gains
> you can get over the hardware MMU doing it are not going to outweigh it.

It's architecture-dependent; not all architectures are even capeable of
walking the page table trees in hardware. They compensate with
lightweight traps for TLB cache misses. 

Andrew Wade
