Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWAXVPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWAXVPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWAXVPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:15:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13752 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750729AbWAXVPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:15:41 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <1138137060.14675.73.camel@localhost.localdomain>
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
	 <43D52592.8080709@watson.ibm.com>
	 <m1oe22lp69.fsf@ebiederm.dsl.xmission.com>
	 <1138050684.24808.29.camel@localhost.localdomain>
	 <m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
	 <1138062125.24808.47.camel@localhost.localdomain>
	 <m17j8pl95v.fsf@ebiederm.dsl.xmission.com>
	 <1138137060.14675.73.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 22:15:05 +0100
Message-Id: <1138137305.2977.92.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 21:11 +0000, Alan Cox wrote:
> On Maw, 2006-01-24 at 12:26 -0700, Eric W. Biederman wrote:
> > There is at least NFS lockd that appreciates having a single integer
> > per process unique identifier.  So there is a practical basis for
> > wanting such a thing.
> 
> Which gets us back to refcounting.
> 
> > At least for this first round I think talking about a kpid
> > as a container, pid pair makes a lot of sense for the moment, as
> > the other implementations just confuse things.
> 
> As an abstract object a kpid to me means a single identifier which
> uniquely identifies the process and which in its component parts be they
> pointers or not uniquely identifies the process in the container and the
> container in the system, both correctly refcounted against re-use.

they why not just straight use the task struct pointer for this? It's
guaranteed unique.. ;)


