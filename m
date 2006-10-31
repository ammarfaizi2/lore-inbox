Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422891AbWJaIjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWJaIjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbWJaIjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:39:17 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:32609 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1422891AbWJaIjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:39:15 -0500
Message-ID: <45470AB3.4050107@openvz.org>
Date: Tue, 31 Oct 2006 11:34:59 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Pavel Emelianov <xemul@openvz.org>, Paul Jackson <pj@sgi.com>,
       vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       menage@google.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com>	 <45460743.8000501@openvz.org>	<20061030062332.856dcc32.pj@sgi.com>	 <45460E69.7070505@openvz.org> <20061030071838.7988d3e1.pj@sgi.com>	 <454619B9.8030705@openvz.org> <1162254377.2715.169.camel@localhost.localdomain>
In-Reply-To: <1162254377.2715.169.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

> 	Yes. The controller should stay in memory until userspace decides that
> control of the resource is no longer desired. Though not all controllers
> should be removable since that may impose unreasonable restrictions on
> what useful/performant controllers can be implemented.
> 
> 	That doesn't mean that the controller couldn't reclaim memory it uses
> when it's no longer needed.
> 


I've already answered Paul Menage about this. Shortly:

... I agree that some users may want to create some
kind of "persistent" beancounters, but this must not be
the only way to control them...
... I think that we may have something [like this] - a flag
BC_PERSISTENT to keep beancounters with zero refcounter in
memory to reuse them...
... I have nothing against using configfs as additional,
optional interface, but I do object using it as the only
window inside BC world...

Please, refer to my full reply for comments.
