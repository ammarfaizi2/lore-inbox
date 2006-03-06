Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWCFVda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWCFVda (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWCFVda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:33:30 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:43527 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932261AbWCFVd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:33:29 -0500
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: Re: [PATCH 6/6] IB: userspace support for RDMA connection manager
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX4011XvpFVjCRG00000009@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 13:33:25 -0800
In-Reply-To: <ORSMSX4011XvpFVjCRG00000009@orsmsx401.amr.corp.intel.com> (Sean Hefty's message of "Mon, 6 Mar 2006 11:21:04 -0800")
Message-ID: <adaoe0j5kd6.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Mar 2006 21:33:26.0046 (UTC) FILETIME=[9A281BE0:01C64165]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +struct rdma_ucm_query_route_resp {
 > +	__u64 node_guid;
 > +	struct ib_user_path_rec ib_route[2];
 > +	struct sockaddr_in6 src_addr;
 > +	struct sockaddr_in6 dst_addr;
 > +	__u32 num_paths;
 > +	__u8 port_num;
 > +	__u8 reserved[3];
 > +};

Is there a 32-bit/64-bit compatibility problem here?  From a quick
look, struct sockaddr_in6 is not 8-byte aligned.

 - R.
