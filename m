Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWAVP4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWAVP4M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 10:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWAVP4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 10:56:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33984 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751280AbWAVP4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 10:56:11 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Arjan van de Ven <arjan@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <m18xt8mffq.fsf@ebiederm.dsl.xmission.com>
References: <20060117143258.150807000@sergelap>
	 <20060117143326.283450000@sergelap>
	 <1137511972.3005.33.camel@laptopd505.fenrus.org>
	 <20060117155600.GF20632@sergelap.austin.ibm.com>
	 <1137513818.14135.23.camel@localhost.localdomain>
	 <1137518714.5526.8.camel@localhost.localdomain>
	 <20060118045518.GB7292@kroah.com>
	 <1137601395.7850.9.camel@localhost.localdomain>
	 <m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	 <43D14578.6060801@watson.ibm.com>
	 <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	 <CC5052ED-FEC1-4B0C-A8A7-3CD190ADF0D3@mac.com>
	 <m18xt8mffq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 16:55:25 +0100
Message-Id: <1137945325.3328.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> A pointer to a task_struct while it kind of sort of works.  Is not
> a good solution.  The problem is that in a lot of cases we register
> a pid to get a signal or something similar and then we never unregister
> it.  So by using a pointer to a trask_struct you effectively hold the
> process in memory forever.

this is not right. Both the PID and the task struct have the exact same
lifetime rules, they HAVE to, to guard against pid reuse problems.


