Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWIUUK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWIUUK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWIUUK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:10:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:8717 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751542AbWIUUK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:10:28 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=OGJZJSGTzQ9JtldLBZBhPalEwi9u3WBgD5CdIAX3KCiLFn8LkLFYl4ooTXLI/1FzN
	QD/+UaVAG1jvgfeR8RYzw==
Message-ID: <6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
Date: Thu, 21 Sep 2006 13:10:22 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: "Paul Jackson" <pj@sgi.com>, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org, clameter@sgi.com
In-Reply-To: <1158869186.6536.205.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	 <1158798715.6536.115.camel@linuxchandra>
	 <20060920173638.370e774a.pj@sgi.com>
	 <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	 <1158803120.6536.139.camel@linuxchandra>
	 <6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
	 <1158869186.6536.205.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > The current fake numa support requires you to choose your node layout
> > at boot time - I've been working with 64 fake nodes of 128M each,
> > which gives a reasonable granularity for dividing a machine between
> > multiple different sized jobs.
>
> It still will not satisfy what OpenVZ/Container folks are looking for:
> 100s of containers.

Right - so fake-numa is not the right solution for everyone, and I
never suggested that it is. (Having said that, there are discussions
underway to make the zone-based approach more practical - if you could
have dynamically-resizable nodes, this would be more applicable to
openvz).

But, there's no reason that the OpenVZ resource control mechanisms
couldn't be hooked into a generic process container mechanism along
with cpusets and RG.

Paul
