Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751894AbWKBHlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWKBHlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbWKBHlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:41:00 -0500
Received: from smtp-out.google.com ([216.239.45.12]:5017 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751894AbWKBHk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:40:59 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=L0OrE2w7YJGavJ9cHAVJRx1RgrE+3n6NMarCbkSKY5OSGf5rFyUTbSWjFWzgjfwz4
	SKCCDmbRoo4seVZh1osmA==
Message-ID: <6599ad830611012340s45323480w63c1d131eb75ae19@mail.gmail.com>
Date: Wed, 1 Nov 2006 23:40:43 -0800
From: "Paul Menage" <menage@google.com>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
In-Reply-To: <454965E5.7090005@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	 <20061101173356.GA18182@in.ibm.com> <45490F0D.7000804@nortel.com>
	 <6599ad830611011548h4c0273c0xc5a653ea8726a692@mail.gmail.com>
	 <454965E5.7090005@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/06, Chris Friesen <cfriesen@nortel.com> wrote:
> Paul Menage wrote:
>
> > The framework should be flexible enough to let controllers register
> > any control parameters (via the filesystem?) that they need, but it
> > shouldn't contain explicit concepts like guarantees and limits.
>
> If the framework was able to handle arbitrary control parameters, that
> would certainly be interesting.
>
> Presumably there would be some way for the controllers to be called from
> the framework to validate those parameters?

The approach that I had in mind was that each controller could
register what ever control files it wanted, which would appear in the
filesystem directories for each container; reads and writes on those
files would invoke handlers in the controller. The framework wouldn't
care about the semantics of those control files. See the containers
patch that I posted last month for some examples of this.

Paul
