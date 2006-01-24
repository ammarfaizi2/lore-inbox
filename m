Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWAXG5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWAXG5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 01:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAXG5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 01:57:02 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3461 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932239AbWAXG46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 01:56:58 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Arjan van de Ven <arjan@infradead.org>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Greg KH <greg@kroah.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <43D5557F.9060006@watson.ibm.com>
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
	 <43D5557F.9060006@watson.ibm.com>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 07:56:28 +0100
Message-Id: <1138085789.2977.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> In that case, I think we do require the current vpid_to_pid(translations)
> in order to transfer the external user pid ( relative to the namespace )
> into one that combines namespace (aka container_id) with the external pid.
> Exactly how it is done today.
> What will slightly change is the low level implementations of the
> 
> inline pid_t pid_to_vpid_ctx(pid_t pid, const struct task_struct *ctx);
> pid_t __pid_to_vpid_ctx_excp(pid_t pid, int pidspace_id,const struct task_struct *ctx);
> 
> and reverse.
> The VPID_2_PID and PID_2_VPID still remain at same locations.
> 
> Did I get your comments correctly, Eric ?..

please call it 'userpid' not 'vpid', to make more clear what the pid is
used for/what domain it is in.


