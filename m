Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVFVBcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVFVBcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVFVBc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:32:26 -0400
Received: from smtp05.auna.com ([62.81.186.15]:41167 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S262503AbVFVBbV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:31:21 -0400
Date: Wed, 22 Jun 2005 01:31:15 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Cpu utilization per thread
To: N Chandra Shekhar REDDY <ncs.reddy@st.com>
Cc: linux-kernel@vger.kernel.org
References: <07f701c5765f$cd437cd0$99bcc68a@blr.st.com>
In-Reply-To: <07f701c5765f$cd437cd0$99bcc68a@blr.st.com> (from
	ncs.reddy@st.com on Tue Jun 21 14:50:27 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119403875l.7816l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Wed, 22 Jun 2005 03:31:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.21, N Chandra Shekhar REDDY wrote:
> Hi all,
> Can any body tell me 
> How to find cpu utilization per thread excluding wait times and sleep times?
> Regards
> ncs
> 

man getrusage.

Pay special attention to the RUSAGE_SELF or RUSAGE_CHILDREN
flag, but I think current linux kernel does not perform a correct account
for threads rusage in the parent. Probably you will have to account each
thread, return info to the parent and sum or average (sum cpu times,
average elapsed times...)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


