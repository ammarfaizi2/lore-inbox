Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVA0CBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVA0CBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVAZXrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:47:00 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:36997 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262049AbVAZTSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:18:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mH7tIrmnZoP3tt6QxzhCoxIYcBPXmNdLTdqDOPdpcFg7L9SGRuqc3zzgockNUY+D/y5Ml9Q05CxKMjxSU6LOs5x1QLhNUQlen5pA4mPRSMfz0W8Rq2V0iE5uKZqbN4T8xSLCMjRk+u76ZkdevEid34B1ocgyaRKIhUZNZokA8go=
Message-ID: <41b516cb0501261111e5edbc5@mail.gmail.com>
Date: Wed, 26 Jan 2005 11:11:25 -0800
From: Chris Leech <chris.leech@gmail.com>
Reply-To: Chris Leech <chris.leech@gmail.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [BUG] Onboard Ethernet Pro 100 on a SMP box: a very strange errors
In-Reply-To: <20050126073749.A2142@natasha.ward.six>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122014646.A1038@natasha.ward.six>
	 <200501252319.11304.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20050126073749.A2142@natasha.ward.six>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 07:37:49 +0500, Denis Zaitsev <zzz@anda.ru> wrote:
> On Tue, Jan 25, 2005 at 11:19:11PM +0200, Denis Vlasenko wrote:
> >
> > Something corrupts packets. It can be sending NIC, switch in the middle,
> > or receiving NIC.
> 
> Changing the receiving card closes the question.  Doesn't it matter?

Take a look at this technical advisory for the STL2 board, I'm fairly
sure this is your issue.
http://support.intel.com/support/motherboards/server/sb/CS-010790.htm

IP fragmented packets as part of an NFS file transfer are improperly
being identified as TCO management packets and are being routed to the
BMC.  The fix is to upgrade the BMC firmware.

Updated BMC firmware and BIOS images for this board are available at
http://support.intel.com/support/motherboards/server/STL2/sb/CS-007118.htm

- Chris
