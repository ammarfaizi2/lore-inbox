Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161495AbWJaEPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161495AbWJaEPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161620AbWJaEPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:15:30 -0500
Received: from smtp-out.google.com ([216.239.45.12]:23517 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161495AbWJaEP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:15:29 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=HSRhNutvjuv/x1Uz5cFivRyhfq5ZmlLwOWVapQgq/58s5NiL3WfzCUjRBZERa5m5U
	b/BhuECtaD/UzOR7yV12A==
Message-ID: <6599ad830610302015r473bee49pd8c0381a1ca04742@mail.gmail.com>
Date: Mon, 30 Oct 2006 20:15:11 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [PATCH] Allow a larger buffer for writes to cpuset files
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061030200053.f9836cce.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6599ad830610301838i65a00d85g82647435ea4581a4@mail.gmail.com>
	 <20061030200053.f9836cce.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Paul Jackson <pj@sgi.com> wrote:
>
> How about coding for the possibility that either NR_CPUS or MAX_NUMNODES
> is larger, and removing 'cpu' from the comment:
>
>         /* Crude upper limit on largest legitimate list user might write. */
>         if (nbytes > 100 + 6 * max(NR_CPUS, MAX_NUMNODES))
>

Yes, that does seem like a better idea.

Paul
