Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290152AbSAKW7J>; Fri, 11 Jan 2002 17:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290156AbSAKW64>; Fri, 11 Jan 2002 17:58:56 -0500
Received: from nat.transgeek.com ([66.92.79.28]:63737 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S290152AbSAKW6k>;
	Fri, 11 Jan 2002 17:58:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: if BUG() optimizations question
Date: Fri, 11 Jan 2002 17:59:12 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020111185611.1BF52C73A5@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have changed almost all of the instances of if(blah) BUG(); in 2.5.2-pre11 
to use if(unlikely(blah)) BUG(); or the macro BUG_ON(blah); if anyone would 
like this I can give you your portion.  It actually does make a difference, 
if there is a gcc op likely(blah) then for the remaining if(blah) digahole; 
else BUG(); will be chainged soon as well.


I hope that this makes sense as it was a fairly trivial change, it just took 
a while as everyone writes the BUG(); stuff differently.



Craig.
