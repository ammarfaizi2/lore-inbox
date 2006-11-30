Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759059AbWK3IIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759059AbWK3IIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759062AbWK3IIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:08:40 -0500
Received: from smtp-out.google.com ([216.239.33.17]:22229 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1759059AbWK3IIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:08:39 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=tSFLt8yY6ajHCPzE459vcjbDFG3nL2iNfiXSGvKq017m74SygT2XF4geN9bOEtDg1
	1Iajbrxud9n3539gOi+2A==
Message-ID: <6599ad830611300008n329ca4a5s133ac62a35bb8d06@mail.gmail.com>
Date: Thu, 30 Nov 2006 00:08:36 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [RFC] dynsched - different cpu schedulers per cpuset
Cc: "Felix Obenhuber" <felix@obenhuber.de>, linux-kernel@vger.kernel.org,
       dynsched-devel@lists.sourceforge.net
In-Reply-To: <20061129201310.54da1618.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1164557189.10306.12.camel@athrose>
	 <20061129201310.54da1618.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, Paul Jackson <pj@sgi.com> wrote:
>
> Your dynamic scheduler mechanisms appear (from what I can tell after a
> brief glance) to be a candidate for being such a controller.

Possibly, if it was some kind of multi-level scheduler - i.e. a
top-level scheduler picks which container to run, and then a
configurable per-container scheduler picks a task from that container.

But (having glanced at the code even less than you) it sounded like it
was intended to be a single level scheduler, configured on a per-cpu
basis. In that case tying it to (exclusive) cpusets sounds like it
might be more reasonable.

Paul.
