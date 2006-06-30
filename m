Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWF3QO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWF3QO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWF3QO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:14:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:25578 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932273AbWF3QOz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:14:55 -0400
Date: Fri, 30 Jun 2006 11:14:42 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Daniel Lezcano <dlezcano@fr.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Sam Vilain <sam@vilain.net>,
       hadi@cyberus.ca, Herbert Poetzl <herbert@13thfloor.at>,
       Alexey Kuznetsov <alexey@sw.ru>, viro@ftp.linux.org.uk,
       devel@openvz.org, dev@sw.ru, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrey Savochkin <saw@swsoft.com>, Ben Greear <greearb@candelatech.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: strict isolation of net interfaces
Message-ID: <20060630161442.GA27210@sergelap.austin.ibm.com>
References: <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net> <44A450D1.2030405@fr.ibm.com> <20060630023947.GA24726@sergelap.austin.ibm.com> <44A517B4.4010500@fr.ibm.com> <m1veqibu8n.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1veqibu8n.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> This whole debate on network devices show up in multiple network namespaces
> is just silly.  The only reason for wanting that appears to be better management.

A damned good reason.  Clearly we want the parent namespace to be able
to control what the child can do.  So whatever interface a child gets,
the parent should be able to somehow address.  Simple iptables rules
controlling traffic between it's own netdevice and the one it hands it's
children seem a good option.

> We have deeper issues like can we do a reasonable implementation without a
> network device showing up in multiple namespaces.

Isn't that the same issue?

> If we can get layer 2 level isolation working without measurable overhead
> with one namespace per device it may be worth revisiting things.  Until
> then it is a side issue at best.

Ok, and in the meantime we can all use the network part of the bsdjail
lsm?  :)

-serge
