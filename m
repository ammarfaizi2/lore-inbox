Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbUKEBLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbUKEBLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUKEBIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:08:15 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:54993 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262541AbUKEBEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:04:33 -0500
Date: Fri, 5 Nov 2004 02:04:27 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Patrick McHardy <kaber@trash.net>, matthias.andree@gmx.de,
       netfilter-devel@lists.netfilter.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps
Message-ID: <20041105010427.GA2770@merlin.emma.line.org>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	Patrick McHardy <kaber@trash.net>,
	netfilter-devel@lists.netfilter.org, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20041104121522.GA16547@merlin.emma.line.org> <418A7B0B.7040803@trash.net> <20041104231734.GA30029@merlin.emma.line.org> <418AC0F2.7020508@trash.net> <20041104160655.1c66b7ef.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104160655.1c66b7ef.davem@davemloft.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2004, David S. Miller wrote:

> His patch isn't correct, even making a temporary change to
> a shared SKB is illegal.

So the original ip_conntrack_amanda was already illegal. If only such
nonsense caused heavy kernel logging (let it oops or GPF or whatver),
that's a much quicker way to pinpoint the bug than run amanda with a
special devnull configuration some dozen times.

> Things like tcpdump could see corrupt SKB contents if they look during
> that tiny window when the newline character has been changed to NULL
> by the amanda conntrack module.

Where is the SKB stuff documented?

-- 
Matthias Andree
