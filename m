Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262775AbSI1Jlh>; Sat, 28 Sep 2002 05:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262777AbSI1Jlh>; Sat, 28 Sep 2002 05:41:37 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:14587 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262775AbSI1Jlg>; Sat, 28 Sep 2002 05:41:36 -0400
Subject: Re: Assert failure, IDE ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020928004448.GA764@gnuppy.monkey.org>
References: <20020928004448.GA764@gnuppy.monkey.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Sep 2002 10:52:15 +0100
Message-Id: <1033206735.17717.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 01:44, Bill Huey wrote:
> 
> Hello,
> 
> In 2.5.39, I get at boot time:
> 

IDE calls request_irq. It needs to call it with locks held but
internally request_irq does sleeping allocations. Once request_irq is
fixed the problem should go away.


Alan

