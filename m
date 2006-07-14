Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWGNRnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWGNRnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWGNRnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:43:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:736 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422684AbWGNRnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:43:10 -0400
Subject: Re: [RFC][PATCH 4/6] slim: secfs patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1152897882.23584.7.camel@localhost.localdomain>
References: <1152897882.23584.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 10:43:03 -0700
Message-Id: <1152898983.314.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 10:24 -0700, Kylene Jo Hall wrote:
> 
> +static ssize_t slm_read_level(struct file *file, char __user *buf,
> +                             size_t buflen, loff_t *ppos)
> +{
> +       struct slm_tsec_data *cur_tsec = current->security;
> +       ssize_t len;
> +       char *page = (char *)__get_free_page(GFP_KERNEL); 

Do you really need a page here?  Why not just use kmalloc()?

-- Dave

