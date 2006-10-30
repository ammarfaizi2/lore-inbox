Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWJ3SHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWJ3SHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWJ3SHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:07:19 -0500
Received: from smtp-out.google.com ([216.239.45.12]:55899 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932468AbWJ3SHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:07:17 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=v10jxh3XnqC2Xj1imeq1hmHzvzwu5QOYryGGmaceDSxvs2q4YIjNvIpjITpzW//tj
	kdNWNk9XPObYVeoDYEigw==
Message-ID: <6599ad830610301007n2c974199m407f3818dd77365a@mail.gmail.com>
Date: Mon, 30 Oct 2006 10:07:05 -0800
From: "Paul Menage" <menage@google.com>
To: "Dave McCracken" <dmccr@us.ibm.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: ckrm-tech@lists.sourceforge.net, dev@openvz.org,
       linux-kernel@vger.kernel.org, devel@openvz.org
In-Reply-To: <200610301116.04780.dmccr@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <20061030024320.962b4a88.pj@sgi.com>
	 <20061030170916.GA9588@in.ibm.com>
	 <200610301116.04780.dmccr@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Dave McCracken <dmccr@us.ibm.com> wrote:
>
> Is there any user demand for heirarchy right now?  I agree that we should
> design the API to allow heirarchy, but unless there is a current need for it
> I think we should not support actually creating heirarchies.  In addition to
> the reduction in code complexity, it will simplify the paradigm presented to
> the users.  I'm a firm believer in not giving users options they will never
> use.

The current CPUsets code supports hierarchies, and I believe that
there are people out there who depend on them (right, PaulJ?) Since
CPUsets are at heart a form of resource controller, it would be nice
to have them use the same resource control infrastructure as other
resource controllers (see the generic container patches that I sent
out as an example of this). So that would be at least one user that
requires a hierarchy.

Paul
