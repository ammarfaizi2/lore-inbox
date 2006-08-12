Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWHLKbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWHLKbf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 06:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWHLKbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 06:31:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:17284 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932118AbWHLKbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 06:31:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dQyTjDdqK+SKUjVSRTuirh4cosC4d6cs8yrCUwwLhT0auktdS4hPk3z0g5DEeiRuzjv1X2qBCUjKe9S4I+LkUMyH1aSU0VEvykAsKaGdEhsyUxIGNRx44grQmqObgrTxelDEJQZyLRhYhGB2jmBi3johxxI04UJRwhoNE5llruQ=
Message-ID: <62b0912f0608120331k5f4131d1kce351db3de223aaf@mail.gmail.com>
Date: Sat, 12 Aug 2006 12:31:33 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: ext3 corruption
In-Reply-To: <62b0912f0608120154s1b158732y5da52b17583fdfa0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <17627.23159.236724.190546@stoffel.org>
	 <200608111326.k7BDQ7fp004102@laptop13.inf.utfsm.cl>
	 <62b0912f0608120154s1b158732y5da52b17583fdfa0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> A solution to your example is to fix two of the three broken pieces of
> software by splitting B into B1 and B2, and either A or C into their
> components likewise:
>
> A1 --> B1 --> C --> B2 --> A2
>
>  -or-
>
> C1 --> B1 --> A --> B2 --> C2

To clarify, by the above I didn't necessarily mean "split one process
into two processes".  A kernel API where you can wait for a named
object or a subsystem to complete it's startup / shutdown would be
just as well.  Or simply waiting on (dis-)appearance of named files in
a dedicated directory named "boot_sequence" in sysfs, would be another
equally fine way to accomplish above scheme.
