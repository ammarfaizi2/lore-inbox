Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422630AbWJ3UsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWJ3UsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422636AbWJ3UsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:48:17 -0500
Received: from smtp-out.google.com ([216.239.45.12]:2442 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1422630AbWJ3UsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:48:16 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=A/Zefo/ct9+y7PEPJ2ClhMBAYd3QtEGQTitQYEuFbRPgGsB3KDqqi6RYfMVVgtZsG
	QUT7kf8DHO5deq8uipJZA==
Message-ID: <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
Date: Mon, 30 Oct 2006 12:47:59 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061030123652.d1574176.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	 <20061030031531.8c671815.pj@sgi.com>
	 <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
	 <20061030042714.fa064218.pj@sgi.com>
	 <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
	 <20061030123652.d1574176.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Paul Jackson <pj@sgi.com> wrote:
>
> In other words you are recommending delivering a system that internally
> tracks separate hierarchies for each resource control entity, but where
> the user can conveniently overlap some of these hierarchies and deal
> with them as a single hierarchy.

More or less. More concretely:

- there is a single hierarchy of process containers
- each process is a member of exactly one process container

- for each resource controller, there's a hierarchy of resource "nodes"
- each process container is associated with exactly one resource node
of each type

- by default, the process container hierarchy and the resource node
hierarchies are isomorphic, but that can be controlled by userspace.

Paul
