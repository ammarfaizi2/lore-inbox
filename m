Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWISQdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWISQdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWISQdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:33:39 -0400
Received: from smtp-out.google.com ([216.239.33.17]:17572 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030203AbWISQdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:33:38 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=oCPyiWE3DTesmUSzQciUSIdq7lTjaVQcbXCJktZeMMwX+RZq/uyNtCV+0z9xJeCSN
	HobzLUPVjsumj4HAj6Oxg==
Subject: Re: [Patch03/05]- Containers: Initialization and Configfs interface
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200609191538.k8JFc6cY022534@turing-police.cc.vt.edu>
References: <1158284486.5408.154.camel@galaxy.corp.google.com>
	 <200609191538.k8JFc6cY022534@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 19 Sep 2006 09:33:15 -0700
Message-Id: <1158683595.18533.53.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 11:38 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 14 Sep 2006 18:41:26 PDT, Rohit Seth said:
> 
> > --- linux-2.6.18-rc6-mm2.org/kernel/container_configfs.c	1969-12-31 16:00:00.000000000 -0800
> > +++ linux-2.6.18-rc6-mm2.ctn/kernel/container_configfs.c	2006-09-14 16:18:45.000000000 -0700
> 
> > +static ssize_t simple_containerfs_attr_show(struct config_item *item,
> > +		struct configfs_attribute *attr,
> > +		char *page)
> ...
> > +	switch (ctfs_attr->idx) {
> > +	case CONFIGFS_CTN_ATTR_ID:
> > +		tmp = sc->ctn.id;
> > +		break;
> ...
> > +	return sprintf(page, "%ld\n", tmp);
> 
> What use is this value, given that we already have containers/user_friendly_name
> to use in the filesystem namespace?  Or is this a mostly-debugging thing?

I think ids (numeric numbers) will be useful when printing the
information in /proc/<pid>/container  User land tools don't necessarily
have to parse the (name) string in that case.

-rohit

