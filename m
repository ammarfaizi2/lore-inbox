Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTJNWgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTJNWgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 18:36:42 -0400
Received: from rth.ninka.net ([216.101.162.244]:28581 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261662AbTJNWgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 18:36:41 -0400
Date: Tue, 14 Oct 2003 15:35:26 -0700
From: "David S. Miller" <davem@redhat.com>
To: Tim Hockin <thockin@hockin.org>
Cc: inaky.perez-gonzalez@intel.com, san_madhav@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Question on atomic_inc/dec
Message-Id: <20031014153526.5904b7c7.davem@redhat.com>
In-Reply-To: <20031014214437.GA30302@hockin.org>
References: <A20D5638D741DD4DBAAB80A95012C0AED78649@orsmsx409.jf.intel.com>
	<20031014214437.GA30302@hockin.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003 14:44:37 -0700
Tim Hockin <thockin@hockin.org> wrote:

> Is there any reason NOT to use the atomic ops in user-space?  I mean, are
> they privileged on some architectures, or ...?

Yes, they are.  Some use interrupt disabling and a spinlock inside
the kernel to implement the atomicity.
