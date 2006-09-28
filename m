Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWI1Xsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWI1Xsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWI1Xsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:48:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18662 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964941AbWI1Xs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:48:29 -0400
Date: Thu, 28 Sep 2006 16:48:08 -0700
From: Paul Jackson <pj@sgi.com>
To: menage@google.com
Cc: akpm@osdl.org, ckrm-tech@lists.sourceforge.net, mbligh@google.com,
       rohitseth@google.com, winget@google.com, dev@sw.ru, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] Cpusets hooked into containers
Message-Id: <20060928164808.87a9fa18.pj@sgi.com>
In-Reply-To: <20060928111408.095816000@menage.corp.google.com>
References: <20060928104035.840699000@menage.corp.google.com>
	<20060928111408.095816000@menage.corp.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Menage wrote:
> +#ifdef CONFIG_CPUSETS
> +	err = cpuset_create(cont);
> +	if (err) goto err_unlock_free;
> +#endif


I believe recommended kernel style puts the if() statement
on a separate line, as in:

  +#ifdef CONFIG_CPUSETS
  +	err = cpuset_create(cont);
  +	if (err)
  +		goto err_unlock_free;
  +#endif


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
