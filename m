Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVCZDrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVCZDrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVCZDrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:47:43 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:18725 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261930AbVCZDrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:47:41 -0500
Message-Id: <200503260347.AXR12129@mira-sjc5-e.cisco.com>
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Chris Wright'" <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>, <torvalds@osdl.org>, <akpm@osdl.org>
Subject: RE: Linux 2.6.11.6
Date: Fri, 25 Mar 2005 19:47:36 -0800
Organization: Cisco Systems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUxtiviXGHe+gIiQUW8uwy17G1V3QAAC4yg
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
In-Reply-To: <20050326034142.GW30522@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >  int bt_sock_unregister(int proto)
>  {
> -	if (proto >= BT_MAX_PROTO)
> +	if (proto < 0 || proto >= BT_MAX_PROTO)
>  		return -EINVAL;

Just curious: would it be better to say

if ((unsigned int)proto >= BT_MAX_PTORO)

?

Is it faster too?

Hua
