Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266012AbSIRKdA>; Wed, 18 Sep 2002 06:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266017AbSIRKdA>; Wed, 18 Sep 2002 06:33:00 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:52730
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266012AbSIRKc7>; Wed, 18 Sep 2002 06:32:59 -0400
Subject: Re: BUG() triggered on SMP shutdown, cpu!=0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020918102029.GA1536@werewolf.able.es>
References: <20020918102029.GA1536@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Sep 2002 11:41:45 +0100
Message-Id: <1032345705.20463.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 11:20, J.A. Magallon wrote:
> Hi all...
> 
> I am getting oopses on shutdown, 'cause this bug is popping:

That doesnt suprise me. The code assumes the old scheduler and -aa has
the O(1) scheduler. Grab the fix to that small piece of code from -ac,
or I'm pretty sure from a newer Andrea tree

