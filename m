Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWJWIod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWJWIod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWJWIod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:44:33 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:2653 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751832AbWJWIoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:44:32 -0400
Subject: Re: [PATCH] s390 move to using ktermios structure
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andy Whitcroft <apw@shadowen.org>
Cc: heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-390@vm.marist.edu,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <d55a80b249f79f802547e982a1343b8f@pinky>
References: <1161193659.9363.117.camel@localhost.localdomain>
	 <d55a80b249f79f802547e982a1343b8f@pinky>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 23 Oct 2006 10:44:29 +0200
Message-Id: <1161593069.28813.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-21 at 16:05 +0100, Andy Whitcroft wrote:
> Seem to be getting compile failures due to the switch to ktermios
> in the serial subsystem.  Need this to get S390 to build on
> latest -mm's.
> 
> Not sure if this is all thats needed?  Perhaps someone who groks
> this architecture better can confirm.

A number of people have stumbled over the ktermios struct. The preferred
solution is to remove the declaration of tty_std_termios because it is
already declared in a header file.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


