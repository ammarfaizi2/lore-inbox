Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318866AbSIIUVQ>; Mon, 9 Sep 2002 16:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318868AbSIIUVQ>; Mon, 9 Sep 2002 16:21:16 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:46575
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318866AbSIIUVP>; Mon, 9 Sep 2002 16:21:15 -0400
Subject: Re: oops on 2.4.20-pre5-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Eaton <dan.eaton@rlx.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1031596139.25426.184.camel@dan>
References: <1031596139.25426.184.camel@dan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 21:28:14 +0100
Message-Id: <1031603294.29715.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thats a very very strange machine 8). Your diagnosis is correct. We are
assuming conventional PC north bridge behaviour. I take it this is your
blade systems. 

As far as I can make out from the ALi docs you can't get an ALi north
bridge at anywhere but 0:0.0 in which case making the check

       if(north && north->vendor == ...)

should do the trick.

