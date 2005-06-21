Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVFUVUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVFUVUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVFUVR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:17:28 -0400
Received: from smtp06.auna.com ([62.81.186.16]:46245 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262408AbVFUVN1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:13:27 -0400
Date: Tue, 21 Jun 2005 21:13:19 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Kill signed chars !!! => PPC uses unsigned chars
To: linux-kernel@vger.kernel.org
References: <20050525134933.5c22234a.akpm@osdl.org>
	<1117232503l.24619l.1l@werewolf.able.es>
	<20050621125404.GA13437@alpha.home.local>
	<01ea01c5766c$be955390$2800000a@pc365dualp2>
In-Reply-To: <01ea01c5766c$be955390$2800000a@pc365dualp2> (from
	cutaway@bellsouth.net on Tue Jun 21 16:23:01 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119388399l.25237l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Tue, 21 Jun 2005 23:13:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.21, cutaway@bellsouth.net wrote:
> The signedness of 'char' is never certain between compilers.  There are x86
> C compilers that implemented 'char' as unsigned, others as signed, and
> others that offered a compile switch to do either way if the default didn't
> work with the code being compiled.
> 
> When it matters, just be explicit :)
> 

It is not a problem about chars signedness (i suppose it depends
on processor ops with bytes, if it uses them as signed or unsiged, do sign
extensions and so on...).

The problem is that a function expecting a 'char' is given a 'signed char'
or 'unsigned char'. Just type the arguments the way they are expected.
On PPC, 'char' argument will be unsigned and 'char' parameter also. What
does strcpy() internally doesn't matter. Fine.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


