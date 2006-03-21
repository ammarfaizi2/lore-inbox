Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWCUSzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWCUSzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWCUSzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:55:11 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:921 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932448AbWCUSzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:55:08 -0500
Subject: Re: [RFC] [PATCH 1/7] Add process virtualisation umbrella
	structure (vx_info)
From: Dave Hansen <haveblue@us.ibm.com>
To: Sam Vilain <sam@vilain.net>
Cc: linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060321061333.27638.9112.stgit@localhost.localdomain>
References: <20060321061333.27638.63963.stgit@localhost.localdomain>
	 <20060321061333.27638.9112.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 10:53:05 -0800
Message-Id: <1142967185.10906.188.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 18:13 +1200, Sam Vilain wrote:
> +static inline void release_vx_info(struct vx_info *vxi,
> +       struct task_struct *task)
> +{
> +       might_sleep();
> +
> +       if (atomic_dec_and_test(&vxi->vx_tasks))
> +               unhash_vx_info(vxi);
> +} 

Are these better handled by krefs and their destructors?

-- Dave

