Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318118AbSIOVGt>; Sun, 15 Sep 2002 17:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSIOVGt>; Sun, 15 Sep 2002 17:06:49 -0400
Received: from 62-190-202-229.pdu.pipex.net ([62.190.202.229]:25605 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S318118AbSIOVGt>; Sun, 15 Sep 2002 17:06:49 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209152119.g8FLJ37W000666@darkstar.example.net>
Subject: Re: [BUG?] binfmt_script: interpreted interpreter doesn't work
To: ingo.oeser@informatik.tu-chemnitz.de
Date: Sun, 15 Sep 2002 22:19:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020915220651.C642@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Sep 15, 2002 10:06:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This may well not be bug, rather an intended feature, but please enlighten
> > me why the following doesn't work:
> > 
> > I have two scripts:
> > /home/pozsy/a:
> > #!/bin/sh
> > echo "Hello from a!"
> > 
> > /home/pozsy/b:
> > #!/home/pozsy/a
> > echo "hello from b!"
> > 
> > Both of them has +x permissions.
> > But I cannot execute the /home/pozsy/b script:
> > 
> > Isn't this "indirection" allowed?

The whole #!/foo/bar notation seems to be very mis-understood these days, it is not just notation chosen at random to be an indicator of the interpreter for the rest of the script - a good explaination can be found at faqs.org:

http://www.faqs.org/faqs/unix-faq/faq/part3/section-16.html
