Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWCSBZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWCSBZg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 20:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWCSBZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 20:25:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751135AbWCSBZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 20:25:35 -0500
Date: Sat, 18 Mar 2006 17:19:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, rolandd@cisco.com,
       openib-general@openib.org
Subject: Re: 2.6.16-rc6-mm2: new RDMA CM EXPORT_SYMBOL's
Message-Id: <20060318171926.7cb182fb.akpm@osdl.org>
In-Reply-To: <ORSMSX401FRaqbC8wSA00000004@orsmsx401.amr.corp.intel.com>
References: <20060318172507.GC14608@stusta.de>
	<ORSMSX401FRaqbC8wSA00000004@orsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sean Hefty" <sean.hefty@intel.com> wrote:
>
> >I'm not exactly happy that this tree adds tons of RDMA CM
> >EXPORT_SYMBOL's that are neither currently used nor _GPL.
> 
> The symbols are used by the kernel component that provides userspace support.
> 

There's brevity and then there is obscurity.



+EXPORT_SYMBOL(rdma_wq);
+EXPORT_SYMBOL(rdma_translate_ip);
+EXPORT_SYMBOL(rdma_resolve_ip);
+EXPORT_SYMBOL(rdma_addr_cancel);
+EXPORT_SYMBOL(rdma_create_id);
+EXPORT_SYMBOL(rdma_create_qp);
+EXPORT_SYMBOL(rdma_destroy_qp);
+EXPORT_SYMBOL(rdma_init_qp_attr);
+EXPORT_SYMBOL(rdma_destroy_id);
+EXPORT_SYMBOL(rdma_listen);
+EXPORT_SYMBOL(rdma_resolve_route);
+EXPORT_SYMBOL(rdma_resolve_addr);
+EXPORT_SYMBOL(rdma_bind_addr);
+EXPORT_SYMBOL(rdma_connect);
+EXPORT_SYMBOL(rdma_accept);
+EXPORT_SYMBOL(rdma_reject);
+EXPORT_SYMBOL(rdma_disconnect);
+EXPORT_SYMBOL(ib_get_rmpp_segment);
+EXPORT_SYMBOL(ib_copy_qp_attr_to_user);
+EXPORT_SYMBOL(ib_copy_path_rec_to_user);
+EXPORT_SYMBOL(ib_copy_path_rec_from_user);
+EXPORT_SYMBOL(ib_modify_qp_is_ok);
+EXPORT_SYMBOL(ip_dev_find);

Some or all of those exports have no in-tree users.

What code will use them?

Is it planned that this code be merged?

Please explain the thinking behind the choice of a non-GPL export.  (Yes,
we discussed this when inifiniband was first merged, but it doesn't hurt to
reiterate).

