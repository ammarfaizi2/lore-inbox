Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUBRU4R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUBRU4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:56:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18048 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268079AbUBRU4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:56:01 -0500
Date: Wed, 18 Feb 2004 12:55:45 -0800
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       selinux@tycho.nsa.gov
Subject: Re: [SELINUX] Event notifications via Netlink
Message-Id: <20040218125545.6c499296.davem@redhat.com>
In-Reply-To: <Xine.LNX.4.44.0402181143550.26718-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0402181143550.26718-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 11:52:31 -0500 (EST)
James Morris <jmorris@redhat.com> wrote:

> +/* Message structures */
> +struct selnl_msg_setenforce {
> +	u_int32_t	val;
> +};
 ...
> +	case SELNL_MSG_SETENFORCE: {
> +		struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
> +		
> +		memset(msg, 0, len);
> +		msg->val = *((int *)data);
> +		break;
> +	}

I think there's a "u32" at 'data' not an "int".
